require 'haystack_worker/haystack_worker'

require 'haystack_worker/jobs'
require 'haystack_worker/surpluses'
require 'haystack_worker/benchmark'

require 'benchmark'

class HaystackWorker
  include Jobs, Surpluses, Benchmark

  def initialize(haystack_domain)
    @haystack_domain = haystack_domain
  end

  def self.work(haystack_domain)
    new(haystack_domain).work
  end

  def work
    input = request_job
    loop do
      output = surpluses(input)
      input = respond_with(input, output)
    end
  end
end
