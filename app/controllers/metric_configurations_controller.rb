class MetricConfigurationsController < ApplicationController
  def exists
    respond_with_json(exists: MetricConfiguration.exists?(params[:id].to_i))
  end

  def create
    metric_snapshot = build_metric_snapshot
    @metric_configuration = MetricConfiguration.new(all_params.reject { |key, _| key == 'metric' })
    if valid_metric_snapshot_for_configuration(metric_snapshot, @metric_configuration)
      result = try_to_save_metric_configuration(metric_snapshot)
    else
      result = get_result_from_invalid_metric_configuration(metric_snapshot)
    end
    respond_with_json result[:data], result[:status]
  end

  def try_to_save_metric_configuration(metric_snapshot)
    result = {}
    if save_metric_configuration_with_snapshot(@metric_configuration, metric_snapshot)
      result[:data] = { metric_configuration: @metric_configuration }
      result[:status] = :created
    else
      result = get_result_from_invalid_metric_configuration(metric_snapshot)
    end
    result
  end

  def get_result_from_invalid_metric_configuration(metric_snapshot)
    result = {}
    result[:data] = { errors: @metric_configuration.errors.full_messages + metric_snapshot.errors.full_messages }
    result[:status] = :unprocessable_entity
    result
  end

  def update
    if set_metric_configuration
      metric_configuration_params = all_params
      metric_snapshot = @metric_configuration.metric_snapshot
      # Instead of updating CompoundMetricSnapshot we delete it and create a new one
      if compound_metric_snapshot_parameter? metric_configuration_params
        metric_snapshot = build_metric_snapshot
        replace_metric_snapshot_for_configuration(@metric_configuration, metric_snapshot)
      end
      metric_configuration_params.delete('metric')
      if @metric_configuration.errors.empty? && @metric_configuration.update(metric_configuration_params)
        respond_with_json({ metric_configuration: @metric_configuration }, :created)
      else
        respond_with_json({ errors: @metric_configuration.errors.full_messages + metric_snapshot.errors.full_messages}, :unprocessable_entity)
      end
    end
  end

  def destroy
    if set_metric_configuration
      @metric_configuration.destroy
      respond_with_json
    end
  end

  def show
    respond_with_json(metric_configuration: @metric_configuration) if set_metric_configuration
  end

  private

  def replace_metric_snapshot_for_configuration(metric_configuration, metric_snapshot)
    if metric_snapshot.errors.empty? && metric_configuration.valid_metric_snapshot_code?(metric_snapshot.code)
      metric_configuration.metric_snapshot.destroy
      metric_configuration.metric_snapshot = metric_snapshot
      metric_configuration.save
    end
  end

  def compound_metric_snapshot_parameter?(parameters)
    !parameters['metric'].nil? && parameters['metric']['type'] == 'CompoundMetricSnapshot'
  end

  def save_metric_configuration_with_snapshot(metric_configuration, metric_snapshot)
    metric_configuration.metric_snapshot = metric_snapshot
    metric_configuration.errors.empty? && metric_configuration.save
  end

  def valid_metric_snapshot_for_configuration(metric_snapshot, metric_configuration)
    !metric_snapshot.id.nil? && metric_configuration.valid_metric_snapshot_code?(metric_snapshot.code)
  end

  def set_metric_configuration
    begin
      @metric_configuration = MetricConfiguration.find(params[:id].to_i)
      true
    rescue ActiveRecord::RecordNotFound => exception
      respond_with_json({ errors: [exception.message] }, :not_found)
      false
    end
  end

  def build_metric_snapshot
    MetricSnapshot.create(metric_params)
  end

  def metric_params
    all_params['metric']
  end

  def all_params
    params.require(:metric_configuration).permit(:weight, :aggregation_form, :reading_group_id, :kalibro_configuration_id, metric: [:script, :description, { scope: :type }, :name, :type, :metric_collector_name, :code, :languages])
  end
end
