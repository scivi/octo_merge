require 'spec_helper'

describe OctoMerge::PullRequest do
  include WebmockStubs

  subject(:pull_request) {
    described_class.new(repo: "rails/rails", number: "23")
  }

  its(:remote) { is_expected.to eq("jackdempsey") }
  its(:remote_url) { is_expected.to eq("git@github.com:jackdempsey/rails.git") }
  its(:branch) { is_expected.to eq("fix_requires") }
  its(:number) { is_expected.to eq("23") }

  describe "==" do
    let(:another_pull_request) {
      described_class.new(repo: "rails/rails", number: "23")
    }

    specify { expect(pull_request).to eq(another_pull_request) }
  end
end
