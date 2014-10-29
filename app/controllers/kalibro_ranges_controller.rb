class KalibroRangesController < ApplicationController
  before_action :set_kalibro_range, only: [:destroy, :update]

  def create
    range = KalibroRange.new(kalibro_range_params)

    respond_to do |format|
      if range.save
        format.json { render json: {kalibro_range: range}, status: :created }
      else
        format.json { render json: {kalibro_range: range}, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @kalibro_range.update(kalibro_range_params)
        format.json { render json: {kalibro_range: @kalibro_range}, status: :created }
      else
        format.json { render json: {kalibro_range: @kalibro_range}, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @kalibro_range.destroy

    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
  end

  private
  def set_kalibro_range
    @kalibro_range = KalibroRange.find(params[:id].to_i)
  end

  def kalibro_range_params
    params.require(:kalibro_range).permit(:beginning, :end, :comments, :reading_id, :metric_configuration_id)
  end
end
