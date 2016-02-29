require 'spec_helper'

describe OctoMerge::Context do
  subject {
    described_class.new(
      working_directory: "tmp",
      repo: "rails/rails",
      pull_request_numbers: [23, 42]
    )
  }

  let(:pull_request_23) {
    OctoMerge::PullRequest.new(repo: "rails/rails", number: "23")
  }
  let(:pull_request_42) {
    OctoMerge::PullRequest.new(repo: "rails/rails", number: "23")
  }

  its(:working_directory) { is_expected.to eq("tmp") }
  its(:repo) { is_expected.to eq("rails/rails") }

  its(:pull_requests) { is_expected.to include(pull_request_23) }
  its(:pull_requests) { is_expected.to include(pull_request_42) }
end
