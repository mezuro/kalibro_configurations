class KalibroRangesController < ApplicationController
  before_action :set_kalibro_range, only: [:destroy, :update]
  before_action :set_metric_configuration, only: [:index]
  before_action :set_interval_params, only: [:create, :update]

  def index
    respond_to do |format|
      format.json { render json: {kalibro_ranges: @metric_configuration.kalibro_ranges}}
    end
  end

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

  def set_metric_configuration
    @metric_configuration = MetricConfiguration.find(params[:metric_configuration_id].to_i)
  end

  def set_kalibro_range
    @kalibro_range = KalibroRange.find(params[:id].to_i)
  end

  def kalibro_range_params
    params.require(:kalibro_range).permit(:beginning, :end, :comments, :reading_id, :metric_configuration_id)
  end

  def convert(value)
    if value == "INF"
      return 1.0/0
    elsif value == "-INF"
      return -1.0/0
    end
    return value
  end

  def set_interval_params
    params[:beginning] = convert(params[:beginning])
    params[:end] = convert(params[:end])
  end
end
