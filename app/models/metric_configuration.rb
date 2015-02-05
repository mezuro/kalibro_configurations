class MetricConfiguration < ActiveRecord::Base
  belongs_to :kalibro_configuration
  belongs_to :metric_snapshot, dependent: :destroy
  has_many :kalibro_ranges, dependent: :destroy

  validates :weight, :kalibro_configuration, :metric_snapshot, presence: true
  validates :weight, numericality: { greater_than: 0 }
  validates :metric_snapshot, uniqueness: { scope: :kalibro_configuration_id,
    message: "Should be unique within a Kalibro Configuration" }
  validates :aggregation_form, presence: true, if: "native_metric_snapshot?"

  accepts_nested_attributes_for :metric_snapshot

  def as_json(options={})
    options[:except] = :metric_snapshot_id
    json = super(options)
    json['metric'] = metric_snapshot.as_json(except: [:id, :created_at, :updated_at])

    # Type is considered by ActiveRecord as an implementation detail and so it is ignored by as_json
    # Here we set it, since it is important in our case
    if metric_snapshot.is_a?(NativeMetricSnapshot)
      json['metric']['type'] = 'NativeMetricSnapshot'
    elsif metric_snapshot.is_a?(CompoundMetricSnapshot)
      json['metric']['type'] = 'CompoundMetricSnapshot'
    end

    return json
  end

  def native_metric_snapshot?
    !metric_snapshot.nil? && metric_snapshot.type == "NativeMetricSnapshot"
  end
end
