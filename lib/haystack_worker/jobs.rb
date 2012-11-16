module HaystackWorker::Jobs
  def request_job
    respond_with(nil, [])
  end

  def respond_with(id, results)
    path = job_path(id)
    data = data_for(results)

    json = Net::HTTP.post_form(path, data).body
    hash = JSON.parse(json)

    [hash['id'], ranges_for(hash)]
  end

  private
  def data_for(results)
    { :results => results.to_json }
  end

  def ranges_for(hash)
    if hash['from'] && hash['to']
      pairs = hash['from'].zip(hash['to'])
      pairs.inject([]) { |arr, (f, t)| arr << (f..t) }
    end
  end

  def job_path(id = nil)
    URI("http://#@haystack_domain/job/#{id}")
  end
end
