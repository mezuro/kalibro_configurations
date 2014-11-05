class CodeUniquenessValidator < ActiveModel::Validator
  def validate(record)
    kalibro_configuration = KalibroConfiguration.find(record.kalibro_configuration_id)
    metric_configurations = kalibro_configuration.metric_configurations
    metric_configurations.each do |metric_configuration|
      if metric_configuration.id != record.id && metric_configuration.metric_snapshot.code == record.metric_snapshot.code
        record.errors[:code] << "There is already a metric snapshot with the code #{metric_configuration.metric_snapshot.code}! Please, choose another one."
      end
    end
  end
end
