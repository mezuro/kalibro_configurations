class CompoundMetricSnapshot < MetricSnapshot
  def as_json(options = {})
    # Type is considered by ActiveRecord as an implementation detail and so it is ignored by as_json
    # Here we set it, since it is important in our case
    json = super(options)
    json['type'] = 'CompoundMetricSnapshot'
    json.delete('metric_collector_name')
    json
  end
end
