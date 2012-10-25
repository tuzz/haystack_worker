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

    it 'raises an argument error on a cardinality mismatch' do
      search_space = [1..1] * 25
      expect {
        HaystackWorker.work(search_space)
      }.to raise_error(ArgumentError, /26/)
    end

    it 'raises a type error unless an array of ranges is given' do
      expect {
        HaystackWorker.work(['a'] * 26)
      }.to raise_error(TypeError, /26/)

      expect {
        HaystackWorker.work([123] * 26)
      }.to raise_error(TypeError, /26/)
    end

    it 'coerces list style arguments into an array' do
      search_space = [1..1] * 26
      HaystackWorker.work(*search_space).should be_nil
    end
  end

end
