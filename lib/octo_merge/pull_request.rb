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
      github_api_result.head.repo.ssh_url
    end

    def branch
      github_api_result.head.ref
    end

    def ==(other_pull_request)
      repo == other_pull_request.repo && number == other_pull_request.number
    end

    private

    def github_api_result
      @github_api_result ||= github_client.pull_request(repo, number)
    end

    def github_client
      OctoMerge.github_client
    end
  end
end
