class MetricConfiguration < ActiveRecord::Base
  belongs_to :kalibro_configuration
  belongs_to :metric_snapshot, dependent: :destroy

  validates :kalibro_configuration, :metric_snapshot, presence: true

  accepts_nested_attributes_for :metric_snapshot

  def as_json(options={})
    options[:except] = :metric_snapshot_id
    json = super(options)
    json['metric'] = metric_snapshot.as_json(except: [:id, :created_at, :updated_at])

    return json
  end

  def native_metric_snapshot?
    !metric_snapshot.nil? && metric_snapshot.type == "NativeMetricSnapshot"
  end

  def valid_metric_snapshot_code?(code)
    kalibro_configuration = KalibroConfiguration.find self.kalibro_configuration_id
    kalibro_configuration.metric_configurations.each do |metric_configuration|
      if metric_configuration.id != self.id && code == metric_configuration.metric_snapshot.code
        self.errors[:code] << "must be unique within a kalibro configuration"
        return false
      end
    end
    return true
  end
end
