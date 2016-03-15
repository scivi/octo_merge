require 'spec_helper'

describe OctoMerge::Strategy::MergeWithRebase do
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
end
