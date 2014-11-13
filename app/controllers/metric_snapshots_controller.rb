class MetricSnapshotsController < ApplicationController
  before_action :set_metric_snapshot, only: [:update, :destroy]

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

  def create
    @metric_snapshot = MetricSnapshot.new(metric_snapshot_params)

    respond_to do |format|
      if @metric_snapshot.save
        format.json { render json: {metric_snapshot: @metric_snapshot}, status: :created }
      else
        format.json { render json: {metric_snapshot: @metric_snapshot}, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @metric_snapshot.update(metric_snapshot_params)
        format.json { render json: {metric_snapshot: @metric_snapshot}, status: :ok }
      else
        format.json { render json: {metric_snapshot: @metric_snapshot}, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @metric_snapshot.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_metric_snapshot
      @metric_snapshot = MetricSnapshot.find(params[:id].to_i)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def metric_snapshot_params
      params.require(:metric_snapshot).permit(:type, :name, :description, :code, :metric_collector_name, :scope, :script)
    end
end
