require 'spec_helper'

describe OctoMerge::ListPullRequests do
  include WebmockStubs

  subject(:list_pull_requests) {
    described_class.new(repo: "rails/rails", query: "label: activemodel")
  }

  its(:repo) { is_expected.to eq("rails/rails") }
  its(:query) { is_expected.to eq("label: activemodel") }

  describe "#all" do
    subject(:pull_requests) { list_pull_requests.all }

    it { is_expected.to be_a(Array) }
    its(:length) { is_expected.to eq(19) }

    describe "an item of the array" do
      subject(:pull_request) { pull_requests.first }

      it { is_expected.to be_a(Sawyer::Resource) }
      its(:number) { is_expected.to eq(23983) }
      its(:title) { is_expected.to eq("fix `as_json()` when passing hashes to 'include' array") }

      specify { expect(pull_request.user.login).to eq("rafal-brize") }
    end
  end
end
