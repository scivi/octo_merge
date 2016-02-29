require 'spec_helper'

describe OctoMerge::Configuration do
  subject(:configuration) { described_class.new }

  describe "login=" do
    before ( configuration.login = "foo" )
    its(:login) { is_expected.to eq("foo") }
  end

  describe "password=" do
    before ( configuration.password = "secret" )
    its(:password) { is_expected.to eq("secret") }
  end
end
