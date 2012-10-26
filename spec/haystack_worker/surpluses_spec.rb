require 'spec_helper'

describe HaystackWorker, 'Surpluses' do
  subject { HaystackWorker.new('domain') }

  describe '#surpluses' do
    it 'returns an array of surplus solutions' do
      search_space = [39..40] + (40..64).map { |x| x..x }
      solutions = [(39..64).to_a, [40] + (40..64).to_a]
      subject.surpluses(search_space).should == solutions
    end

    it 'returns nil if there surplus solutions are found' do
      search_space = [1..1] * 26;
      subject.surpluses(search_space).should be_nil
    end

    it 'raises an argument error on a cardinality mismatch' do
      search_space = [1..1] * 25
      expect {
        subject.surpluses(search_space)
      }.to raise_error(ArgumentError, /26/)
    end

    it 'raises a type error unless an array of ranges is given' do
      expect {
        subject.surpluses(['a'] * 26)
      }.to raise_error(TypeError, /26/)

      expect {
        subject.surpluses([123] * 26)
      }.to raise_error(TypeError, /26/)
    end

    it 'coerces list style arguments into an array' do
      search_space = [1..1] * 26
      subject.surpluses(*search_space).should be_nil
    end
  end
end
