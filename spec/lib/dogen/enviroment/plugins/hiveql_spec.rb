require 'spec_helper.rb'

describe Dogen::Enviroment::Plugins::Hiveql do
  before do
    class MockClass
      include Dogen::Enviroment::Plugins::Hiveql::HelperMethods
    end
  end

  describe 'test' do
    it "aa" do
      subject = MockClass.new
      subject.date_loop('2012-11-10', '2012-11-12') do
        p 'aa'
      end
    end
  end

end
