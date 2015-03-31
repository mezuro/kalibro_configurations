json.array!(@statistics) do |statistic|
  json.extract! statistic, :id, :count_metric_configuration
  json.url statistic_url(statistic, format: :json)
end
