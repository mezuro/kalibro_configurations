class MetricConfigurationsController < ApplicationController
  before_action :set_metric_configuration, only: [:show, :edit, :update, :destroy]

  def create
    metric_configuration_params = all_params
    metric_params = metric_configuration_params.delete("metric")

    @metric_configuration = MetricConfiguration.new(metric_configuration_params)
    @metric_configuration.metric_snapshot = MetricSnapshot.create(metric_params)

    respond_to do |format|
      if @metric_configuration.save
        format.json { render json: {metric_configuration: @metric_configuration}, status: :created}
      else
        format.json { render json: {metric_configuration: @metric_configuration}, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @metric_configuration.update(all_params)
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

  private

  def set_metric_configuration
    @metric_configuration = MetricConfiguration.find(params[:id].to_i)
  end

  def all_params
    params.require(:metric_configuration).permit(:weight, :aggregation_form, :reading_group_id, :kalibro_configuration_id, metric: [:script, :description, :scope, :name, :type, :metric_collector_name, :code])
  end
end
