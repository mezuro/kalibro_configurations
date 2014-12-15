class MetricConfigurationsController < ApplicationController
  before_action :set_metric_configuration, only: [:edit, :update, :destroy]

  def create
    metric_snapshot = MetricSnapshot.create(params[:metric_configuration][:metric_snapshot])
    @metric_configuration = MetricConfiguration.new(all_params)
    @metric_configuration.metric_snapshot_id = metric_snapshot.id

    respond_to do |format|
      if @metric_configuration.save
        format.json { render json: {metric_configuration: @metric_configuration}, status: :created}
      else
        format.json { render json: {metric_configuration: @metric_configuration}, status: :unprocessable_entity }
      end
    end
  end

  # We are not letting users to update a Metric Snapshot. Currently, only the parameters of a Metric Configuration can be edited.
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

  def all_params
    params.require(:metric_configuration).permit(:weight, :aggregation_form, :reading_group_id, :kalibro_configuration_id, :metric_snapshot_id, metric_snapshot: [:script, :description, :scope, :name, :type, :metric_collector_name, :code])
  end
end
