class MetricSnapshotsController < ApplicationController
  before_action :set_metric_snapshot, only: [:metric_configuration]

  def index
    respond_to do |format|
      format.json {render json: {metric_snapshots: MetricSnapshot.all}}
    end
  end

  def show
    begin
      set_metric_snapshot
      response = {metric_snapshot: @metric_snapshot}
      status = :ok
    rescue ActiveRecord::RecordNotFound
      response = {error: 'RecordNotFound'}
      status = :unprocessable_entity
    end

    respond_to do |format|
      format.json {render json: response, status: status}
    end
  end

  def metric_configuration
    respond_to do |format|
      format.json { render json: {metric_configuration: @metric_snapshot.metric_configuration}, status: :ok }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_metric_snapshot
      @metric_snapshot = MetricSnapshot.find(params[:id].to_i)
    end
end
