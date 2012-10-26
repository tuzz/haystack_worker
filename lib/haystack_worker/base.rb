class HaystackWorker
  include Jobs, Surpluses, Benchmark

  def initialize(haystack_domain)
    @haystack_domain = haystack_domain
  end

  def self.work(haystack_domain)
    new(haystack_domain).work
  end

  def work
    id, ranges = request_job
    loop do
      results = surpluses(ranges)
      id, ranges = respond_with(id, results)
    end
  end
end
