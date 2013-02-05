require 'spec_helper'

describe "Affiliation Model" do
  let(:affiliation) { Affiliation.new }
  it 'can be created' do
    affiliation.should_not be_nil
  end
end
