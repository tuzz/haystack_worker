require 'spec_helper'

describe HaystackWorker, 'Integration' do
  class HaystackWorker; def loop; yield; end; end

  let(:id) { 123 }
  let(:ranges) { [1..1] * 26 }

  before do
    job = { 'id' => 123, 'ranges' => [1..1] * 26 }.to_json
    haystack = lambda { |_| [200, { 'Content-Type' => 'text/plain' }, [job]] }
    Thread.new { Rack::Handler::WEBrick.run(haystack, :Port => 9292) }
    sleep 1
  end

  describe '.work' do
    it 'carries out work on behalf of the haystack server' do
      path = URI('http://localhost:9292/job/123')
      data = { :results => 'null' }

      HaystackWorker.work('localhost:9292').should == [id, ranges]
    end
  end
end
