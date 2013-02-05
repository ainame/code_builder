require 'spec_helper'

describe "Package Model" do
  let(:package) { Package.new }
  it 'can be created' do
    package.should_not be_nil
  end
end
