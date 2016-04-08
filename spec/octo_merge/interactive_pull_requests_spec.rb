require 'spec_helper'

describe OctoMerge::InteractivePullRequests do
  subject(:interactive) { described_class.new(options) }

  let(:options) do
    {
      repo: "rails/rails",
      query: "label:codereview"
    }
  end

  let(:list_pull_requests) do
    instance_double(OctoMerge::ListPullRequests, all: github_prs)
  end

  let(:github_prs) do
    [
      double("PullRequest", number: 23, title: "Add Foo", user: user),
      double("PullRequest", number: 42, title: "Add Bar", user: user),
      double("PullRequest", number: 66, title: "Add Baz", user: user),
      double("PullRequest", number: 99, title: "Add Oof", user: user),
    ]
  end

  let(:user) { double(login: "John")}

  describe ".get" do
    after { described_class.new(options) }

    # TODO: stub chain "to_s"
    specify { expect(described_class).to receive(:new).with(options) }
  end

  describe "#to_s" do
    subject { interactive.to_s }

    before do
      # Select the first and third PR
      expect(Ask).to receive(:checkbox)
        .with(
          "Select the pull requests you want to merge",
          [
            '23: "Add Foo" by @John',
            '42: "Add Bar" by @John',
            '66: "Add Baz" by @John',
            '99: "Add Oof" by @John'
          ]
        )
        .and_return([true, false, true, false])

      allow(OctoMerge::ListPullRequests).to receive(:new)
        .and_return(list_pull_requests)
    end

    it { is_expected.to eq("23,66") }
  end
end
