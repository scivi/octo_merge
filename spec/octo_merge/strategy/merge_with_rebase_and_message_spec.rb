require 'spec_helper'

describe OctoMerge::Strategy::MergeWithRebaseAndMessage do
  include SetupExampleRepos

  let(:expected_history) do
<<-'EXPECTED_HISTORY'.strip
*   Merge branch 'sunglasses'
|\
| * Adds sunglasses
|/
*   Merge branch 'cowboy_hat'
|\
| * Adds cowboy_hat
|/
* Adds piercing
* Adds tattoo
* Adds earrrings
EXPECTED_HISTORY
  end

  it { is_expected.to eq(expected_history) }

  describe "merge commit" do
    subject { mallory.show("--format=%s%n%n%b") }

    let(:expected_body) {
<<-EXPECTED_BODY
Merge branch 'sunglasses'

Resolves and closes: example.com/42

= Adds sunglasses

== Lorem ipsum

dolor sit amet!


EXPECTED_BODY
    }

    it { is_expected.to eq(expected_body) }
  end
end
