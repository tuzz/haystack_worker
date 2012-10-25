require 'spec_helper'

describe HaystackWorker do

  let(:klass) { subject.class }

  describe '.work' do
    it 'returns an array of surplus solutions' do
      search_space = [39..40] + (40..64).map { |x| x..x }
      solutions = [(39..64).to_a, [40] + (40..64).to_a]
      HaystackWorker.work(search_space).should == solutions
    end

    it 'returns nil if there surplus solutions are found' do
      search_space = [1..1] * 26;
      HaystackWorker.work(search_space).should be_nil
    end
  end

end
