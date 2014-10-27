class MetricConfigurationsController < ApplicationController
  before_action :set_metric_configuration, only: [:show, :edit, :update, :destroy]

  def create
    @metric_configuration = MetricConfiguration.new(metric_configuration_params)

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
      format.html { redirect_to metric_configurations_url, notice: 'Metric configuration was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_metric_configuration
      @metric_configuration = MetricConfiguration.find(params[:id].to_i)
    end

    def metric_configuration_params
      params.require(:metric_configuration).permit(:metric_id, :weight, :aggregation_form, :reading_group_id, :configuration_id)
    end
end
