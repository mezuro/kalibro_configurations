class KalibroRangesController < ApplicationController
  before_action :set_kalibro_range, only: [:destroy]

  def save
    range = KalibroRange.new(params[:range])
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
    @kalibro_range.destroy
    respond_to do |format|
      format.json { render json: @kalibro_range.to_hash, status: :ok }
    end
  end

  def of
    ranges = {ranges: KalibroRange.ranges_of(params[:metric_configuration_id]).map { |range| range.to_hash }}

    respond_to do |format|
      format.json { render json: ranges }
    end
  end

  private
  def set_kalibro_range
    @kalibro_range = KalibroRange.find(params[:id])
  end

  def kalibroparams
    params.require(:kalibro_range).permit(:beginning, :end, :comments, :reading_id, :metric_configuration_id)
  end
end
