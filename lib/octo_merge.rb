require "octo_merge/version"

require "octo_merge/context"
require "octo_merge/execute"
require "octo_merge/git"
require "octo_merge/pull_request"

require "octo_merge/abstract_merge"
require "octo_merge/merge_with_rebase"
require "octo_merge/merge_without_rebase"

module OctoMerge
  def self.run(repo:, pull_request_numbers:, working_directory:, strategy:)
    context = Context.new(
      working_directory: working_directory,
      repo: repo,
      pull_request_numbers: pull_request_numbers
    )

    Execute.new(context: context, strategy: strategy).run
  end
end
