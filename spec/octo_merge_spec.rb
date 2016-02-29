require 'spec_helper'

describe OctoMerge do
  let(:context) { instance_double(OctoMerge::Context) }
  let(:execute) { instance_double(OctoMerge::Execute, run: true) }

  it 'has a version number' do
    expect(OctoMerge::VERSION).not_to be nil
  end

  describe ".run" do
    after do
      OctoMerge.run(
        repo: "rails/rails",
        pull_request_numbers: [23, 42],
        working_directory: "foo/bar",
        strategy: OctoMerge::MergeWithoutRebase
      )
    end

    specify do
      expect(OctoMerge::Context).to receive(:new)
        .with(
          working_directory: "foo/bar",
          repo: "rails/rails",
          pull_request_numbers: [23, 42]
        )
        .and_return(context)

      expect(OctoMerge::Execute).to receive(:new)
        .with(context: context, strategy: OctoMerge::MergeWithoutRebase)
        .and_return(execute)

      expect(execute).to receive(:run)
    end
  end
end
