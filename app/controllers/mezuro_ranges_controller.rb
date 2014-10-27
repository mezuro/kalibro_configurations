class MezuroRangesController < ApplicationController
  before_action :set_mezuro_range, only: [:destroy]

  def save
    range = MezuroRange.new(params[:range])
    range.metric_configuration_id = params[:metric_configuration_id]

    respond_to do |format|
      if range.save
        format.json { render json: range.to_hash }
      else
        format.json { render json: range.to_hash, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @mezuro_range.destroy
    respond_to do |format|
      format.json { render json: @mezuro_range.to_hash, status: :ok }
    end
  end

  def of
    ranges = {ranges: MezuroRange.ranges_of(params[:metric_configuration_id]).map { |range| range.to_hash }}

    respond_to do |format|
      format.json { render json: ranges }
    end
  end

  private
  def set_mezuro_range
    @mezuro_range = MezuroRange.find(params[:id])
  end

  def mezuro_range_params
    params.require(:mezuro_range).permit(:beginning, :end, :comments, :reading_id, :metric_configuration_id)
  end
end
