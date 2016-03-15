module OctoMerge
  module Strategy
    class MergeWithRebase < Base
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
        end
      end
    end
  end
end
