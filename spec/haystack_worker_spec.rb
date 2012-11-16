require 'spec_helper'

describe HaystackWorker, 'Integration' do
  class HaystackWorker; def loop; yield; end; end

  let(:id) { 123 }
  let(:array) { [1] * 26 }

  before do
    job = { 'id' => 123, 'from' => array, 'to' => array }.to_json
    haystack = lambda { |_| [200, { 'Content-Type' => 'text/plain' }, [job]] }
    Thread.new { Rack::Handler::WEBrick.run(haystack, :Port => 9292) }
    sleep 1
  end

  describe '.work' do
    it 'carries out work on behalf of the haystack server' do
      path = URI('http://localhost:9292/job/123')

      HaystackWorker.work('localhost:9292').should == [id, [1..1] * 26]
    end
  end
end
