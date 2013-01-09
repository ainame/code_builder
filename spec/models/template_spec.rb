require 'spec_helper'

describe "Template Model" do
  let(:template) { Template.new }
  it 'can be created' do
    template.should_not be_nil
  end
end
