require 'spec_helper'

describe "Enviroment Model" do
  let(:enviroment) { Enviroment.new }
  it 'can be created' do
    enviroment.should_not be_nil
  end
end
