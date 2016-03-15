require 'spec_helper'

describe OctoMerge::Strategy::Rebase do
  include SetupExampleRepos

  let(:expected_history) do
<<-'EXPECTED_HISTORY'.strip
* Adds sunglasses
* Adds cowboy_hat
* Adds piercing
* Adds tattoo
* Adds earrrings
EXPECTED_HISTORY
  end

  it { is_expected.to eq(expected_history) }
end
