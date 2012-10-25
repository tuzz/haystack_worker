require 'benchmark'

class HaystackWorker
  extend Benchmark

  def self.work(ranges)
    _work(ranges.map { |r| [r.min, r.max] })
  end
end
