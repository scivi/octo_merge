module OctoMerge
  class Context
    attr_reader :working_directory, :repo

    def initialize(working_directory:, repo:, pull_request_numbers:)
      @working_directory = working_directory
      @repo = repo
      @pull_request_numbers = pull_request_numbers
    end

    def pull_requests
      @pull_requests ||= pull_request_numbers.map do |number|
        PullRequest.new(repo: repo, number: number.to_s)
      end
    end

    private

    attr_reader :pull_request_numbers
  end
end
