class MetricConfigurationsController < ApplicationController
  before_action :set_metric_configuration, only: [:edit, :update, :destroy]

  def create
    metric_configuration_params = all_params

    metric_snapshot = build_metric_snapshot
    if !metric_snapshot.id.nil?
      metric_configuration_params.delete('metric')
      @metric_configuration = MetricConfiguration.new(metric_configuration_params)
      @metric_configuration.metric_snapshot = metric_snapshot

      respond_to do |format|
        if @metric_configuration.save
          format.json { render json: {metric_configuration: @metric_configuration}, status: :created}
        else
          format.json { render json: {metric_configuration: @metric_configuration}, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.json { render json: {metric_configuration: metric_configuration_params}, status: :unprocessable_entity }
      end
    end
  end

  def update
    metric_configuration_params = all_params

    if !metric_configuration_params['metric'].nil? && (metric_configuration_params['metric']['type'] == 'compound' || metric_configuration_params['metric']['type'] == 'CompoundMetricSnashot')
      @metric_configuration.metric_snapshot.destroy
      @metric_configuration.metric_snapshot = build_metric_snapshot
      @metric_configuration.save
      metric_configuration_params.delete('metric')
    end

    respond_to do |format|
      if @metric_configuration.update(metric_configuration_params)
        format.json { render json: {metric_configuration: @metric_configuration}, status: :created}
      else
        format.json { render json: {metric_configuration: @metric_configuration}, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @metric_configuration.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  def show
    begin
      set_metric_configuration
      response = {metric_configuration: @metric_configuration}
      status = :ok
    rescue ActiveRecord::RecordNotFound
      response = {error: 'RecordNotFound'}
      status = :unprocessable_entity
    end

    respond_to do |format|
      format.json { render json: response, status: status }
    end
  end

  private

  def set_metric_configuration
    @metric_configuration = MetricConfiguration.find(params[:id].to_i)
  end

  def build_metric_snapshot
    metric_snapshot_params = metric_params

    if metric_snapshot_params['type'] == 'native'
      metric_snapshot_params['type'] = 'NativeMetricSnapshot'
    elsif metric_snapshot_params['type'] == 'compound'
      metric_snapshot_params['type'] = 'CompoundMetricSnapshot'
    end

    return MetricSnapshot.create(metric_snapshot_params)
  end

  def metric_params
    all_params['metric']
  end

  def all_params
    params.require(:metric_configuration).permit(:weight, :aggregation_form, :reading_group_id, :kalibro_configuration_id, metric: [:script, :description, :scope, :name, :type, :metric_collector_name, :code])
  end
end
