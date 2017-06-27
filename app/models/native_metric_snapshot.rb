class NativeMetricSnapshot < MetricSnapshot
  def as_json(options = {})
    # Type is considered by ActiveRecord as an implementation detail and so it is ignored by as_json
    # Here we set it, since it is important in our case
    json = super(options)
    json['type'] = 'NativeMetricSnapshot'
    json.delete('script')
    json
  end
end
