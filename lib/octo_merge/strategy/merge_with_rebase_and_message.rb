require 'tempfile'

module OctoMerge
  module Strategy
    class MergeWithRebaseAndMessage < Base
      def run
        git.checkout(master)
        git.fetch(upstream)
        git.reset_hard("#{upstream}/#{master}")

        pull_requests.each do |pull_request|
          git.remote_add("#{pull_request.remote} #{pull_request.remote_url}")
          git.fetch(pull_request.remote)
          git.checkout(pull_request.branch)
          git.rebase(master)
          git.checkout(master)
          git.merge_no_ff(pull_request.branch)

          add_merge_message(pull_request)
        end
      end

      private

      # TODO: Can we add a custom message to a merge commit in an easier way?
      #
      # Note: It's hard to add a multiline message with `merge --message`.
      #
      # The `--file` options does not work for `git --merge` so we abuse
      # `git commit --amend` to apply this message to the merge commit.
      def add_merge_message(pull_request)
        MergeMessageFile.path_for(pull_request) do |path|
          git.commit("--amend --file=#{path}")
        end
      end

      class MergeMessageFile
        def initialize(pull_request)
          @pull_request = pull_request
          file.write(body)
          file.close
        end

        def self.path_for(pull_request)
          new(pull_request).tap do |file|
            yield(file.path)
            file.delete
          end
        end

        def path
          file.path
        end

        def delete
          file.unlink
        end

        private

        attr_reader :pull_request

        def file
          @file ||= Tempfile.new('merge_commit_message')
        end

        def body
          sanitize <<-BODY
Merge branch '#{pull_request.branch}'

Resolves and closes: #{pull_request.url}

= #{pull_request.title}

#{pull_request.body}
BODY

        end

        def sanitize(body)
          # Replace leading "#" and replace with "="
          body.gsub(/^#+/) { |s| "=" * s.length }
        end
      end

      private_constant :MergeMessageFile
    end
  end
end
