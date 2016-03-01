module OctoMerge
  class ListPullRequests
    attr_reader :repo, :query

    def initialize(repo:, query:)
      @repo = repo
      @query = query
    end

    def all
      @all ||= github_client.search_issues("is:open is:pr repo:#{repo} #{query}")[:items]
    end

    private

    def github_client
      OctoMerge.github_client
    end
  end
end
