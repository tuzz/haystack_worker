module HaystackWorker::Jobs
  def request_job
    respond_with(nil, nil)
  end

  def respond_with(id, results)
    path = job_path(id)
    data = data_for(results)

    json = Net::HTTP.post_form(path, data).body
    hash = with_support_for_ranges { JSON.parse(json) }

    [hash['id'], hash['ranges']]
  end

  private
  def data_for(results)
    { :results => results.to_json }
  end

  def job_path(id = nil)
    URI("http://#@haystack_domain/job/#{id}")
  end

  def with_support_for_ranges(&block)
    hash = yield

    if hash['ranges']
      ranges = hash['ranges'].map { |r| eval(r) }
      hash.merge!('ranges' => ranges)
    end

    hash
  end
end
