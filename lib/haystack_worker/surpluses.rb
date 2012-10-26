module HaystackWorker::Surpluses
  def surpluses(*ranges)
    validate(ranges)
    _surpluses(ranges.map { |r| [r.min, r.max] })
  end

  private
  def validate(ranges)
    ranges.flatten!

    message = 'Please specify 26 ranges as an argument.'
    raise ArgumentError.new(message) unless ranges.count == 26
    raise TypeError.new(message) unless ranges.all? { |r| r.is_a?(Range) }
  end
end
