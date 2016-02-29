module OctoMerge
  class Execute
    attr_reader :context, :strategy

    def initialize(context:, strategy:)
      @context = context
      @strategy = strategy
    end

    def run
      env.run
    end

    def env
      @env ||= strategy.new(
        working_directory: context.working_directory,
        pull_requests: context.pull_requests
      )
    end
  end
end
