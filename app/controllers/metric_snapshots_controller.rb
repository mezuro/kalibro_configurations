class MetricSnapshotsController < ApplicationController

  def index
    respond_to do |format|
      format.json {render json: {metric_snapshots: MetricSnapshot.all}}
    end
  end

  def show
    if set_metric_snapshot
      respond_to do |format|
        format.json {render json: {metric_snapshot: @metric_snapshot}, status: :ok}
      end
    end
  end

  def metric_configuration
    if set_metric_snapshot
      respond_to do |format|
        format.json { render json: {metric_configuration: @metric_snapshot.metric_configuration}, status: :ok }
      end
    end
  end

  private
  def set_metric_snapshot
    begin
      @metric_snapshot = MetricSnapshot.find(params[:id].to_i)
      true
    rescue ActiveRecord::RecordNotFound => exception
      respond_to do |format|
        format.json { render json: {errors: [exception.message]}, status: :unprocessable_entity }
      end
      false
    end
  end
end
