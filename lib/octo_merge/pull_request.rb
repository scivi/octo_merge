require "octokit"

module OctoMerge
  class PullRequest
    attr_reader :repo, :number

    def initialize(repo:, number:)
      @repo = repo
      @number = number.to_s
    end

    def remote
      github_api_result.user.login
    end

    def remote_url
      github_api_result.head.repo.git_url
    end

    def branch
      github_api_result.head.ref
    end

    private

    def github_api_result
      @github_api_result ||= github_client.pull_request(repo, number)
    end

    # TODO: Provide authentication credentials
    def github_client
      @github_client ||= Octokit::Client.new
    end
  end
end
