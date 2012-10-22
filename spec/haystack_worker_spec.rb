require 'spec_helper'

describe HaystackWorker do

  let(:klass) { subject.class }

  describe '.work' do
    it "adds the integers together" do
      klass.work([1, 2, 3]).should == 6
    end
  end

end
