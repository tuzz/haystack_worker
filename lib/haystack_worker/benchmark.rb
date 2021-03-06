require 'benchmark'

module HaystackWorker::Benchmark
  def benchmark(exponentials = 5..7)
    puts "\n::::: Benchmarking :::::\n\n"

    exponentials.map do |i|
      number_of_attempts = 10 ** i
      attempts = [1..10] * i + [1..1] * (26 - i)

      puts "Job size: #{number_of_attempts}\n\n"

      times = 5.times.map do
        time = Benchmark.realtime do
          surpluses(attempts)
        end
        puts time
        time
      end

      average = times.inject(:+) / times.size
      puts "\nAverage: #{average}"

      rate = (number_of_attempts / average).round
      puts "Rate: #{rate} attempts/s/thread\n\n"
    end
  end
end
