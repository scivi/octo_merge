module OctoMerge
  class AbstractMerge
    attr_reader :working_directory, :pull_requests

    def initialize(working_directory:, pull_requests:)
      @working_directory = working_directory
      @pull_requests = pull_requests
    end

    def self.run(*args)
      new(*args).tap { |merge| merge.run }
    end

    def run
      fail "NotImplementedYet"
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
