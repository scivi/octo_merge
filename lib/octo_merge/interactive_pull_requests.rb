module OctoMerge
  # TODO: Write specs
  class InteractivePullRequests
    def initialize(repo:, query:)
      @repo = repo
      @query = query
    end

    def self.get(options = {})
      new(repo: options[:repo], query: options[:query]).pull_requests
    end

    def pull_requests
      display_pull_requests
      display_input_message

      gets.strip
    end

    private

    attr_reader :repo, :query

    def display_pull_requests
      puts "[INFO] Fetching PullRequests. Please wait ...\n\n"

      list.all.each do |pull_request|
        puts format_pull_request(pull_request)
      end
    end

    def display_input_message
      puts "\n\nPlease enter the pull requests you want to merge: (e.g.: '23,42,66'):\n\n"
      print "$: "
    end

    def format_pull_request(pull_request)
      "* #{pull_request.number}:\t\"#{pull_request.title}\" by @#{pull_request.user.login}"
    end

    def list
      @list = OctoMerge::ListPullRequests.new(repo: repo, query: query)
    end
  end
end

