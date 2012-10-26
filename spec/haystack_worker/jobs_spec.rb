require 'spec_helper'

describe HaystackWorker, 'Jobs' do
  subject { HaystackWorker.new('example.com') }

  let(:job) { { 'id' => 123, 'ranges' => [1..1, 2..2] }.to_json }

  before(:all) do
    FakeWeb.allow_net_connect = false
  end

  after(:all) do
    FakeWeb.allow_net_connect = true
  end

  describe '#request_job' do
    before do
      FakeWeb.register_uri(:any, 'http://example.com/job/', :body => job)
    end

    it 'returns the next job' do
      id, ranges  = subject.request_job

      id.should == 123
      ranges.should == [1..1, 2..2]
    end
  end

  describe '#respond_with' do
    before do
      FakeWeb.register_uri(:post, 'http://example.com/job/123', :body => job)
    end

    it 'submits the results for the given job' do
      expectation_hash = { nil => 'null', [[1,1],[2,2]] => '[[1,1],[2,2]]' }

      expectation_hash.each do |results, json|
        data = { :results => json }

        Net::HTTP.should_receive(:post_form).with(anything, data).
          and_return mock(:response, :body => '{}')

        subject.respond_with(123, results)
      end
    end

    it 'returns the next job' do
      id, ranges = subject.respond_with(123, nil)

      id.should == 123
      ranges.should == [1..1, 2..2]
    end
  end
end
