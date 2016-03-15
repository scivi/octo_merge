# == Links
#
# * https://www.atlassian.com/git/tutorials/merging-vs-rebasing/workflow-walkthrough
# * https://www.atlassian.com/git/articles/git-team-workflows-merge-or-rebase/
module OctoMerge
  module Strategy
    class Base
      attr_reader :working_directory, :pull_requests

      def initialize(working_directory:, pull_requests:)
        @working_directory = working_directory
        @pull_requests = pull_requests
      end

      def self.run(*args)
        new(*args).tap { |strategy| strategy.run }
      end

      def run
        fail NotImplementedError
      end

      private

      def git
        @git ||= Git.new(working_directory)
      end

      def upstream
        :upstream
      end

      def master
        :master
      end
    end
  end
end
