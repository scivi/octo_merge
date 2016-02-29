module OctoMerge
  class AbstractMerge
    attr_reader :working_directory, :change_sets

    def initialize(working_directory:, change_sets:)
      @working_directory = working_directory
      @change_sets = change_sets
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
