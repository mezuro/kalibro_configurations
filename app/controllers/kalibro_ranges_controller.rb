class KalibroRangesController < ApplicationController
  before_action :set_interval_params, only: [:create, :update]

  def index
    if set_metric_configuration
      respond_to do |format|
        format.json { render json: {kalibro_ranges: @metric_configuration.kalibro_ranges}}
      end
    end
  end

  def show
    if set_kalibro_range
      respond_to do |format|
        format.json { render json: {kalibro_range: @kalibro_range}, status: :ok }
      end
    end
  end

  def create
    range = KalibroRange.new(kalibro_range_params)

    json = json_conversion(range)
    respond_to do |format|
      if range.save
        json["id"] = range.id
        format.json { render json: {kalibro_range: json}, status: :created }
      else
        format.json { render json: {errors: range.errors.full_messages}, status: :unprocessable_entity }
      end
    end
  end

  def update
    if set_kalibro_range
      respond_to do |format|
        successful_update = @kalibro_range.update(kalibro_range_params)
        json = json_conversion(@kalibro_range)
        if successful_update
          format.json { render json: {kalibro_range: json}, status: :created }
        else
          format.json { render json: {errors: @kalibro_range.errors.full_messages}, status: :unprocessable_entity }
        end
      end
    end
  end

  def destroy
    if set_kalibro_range
      @kalibro_range.destroy

      respond_to do |format|
        format.json { render json: {}, status: :ok }
      end
    end
  end

  def exists
    respond_to do |format|
      format.json { render json: {exists: KalibroRange.exists?(params[:id].to_i)} }
    end
  end

  private

  def set_metric_configuration
    begin
      @metric_configuration = MetricConfiguration.find(params[:metric_configuration_id].to_i)
      true
    rescue ActiveRecord::RecordNotFound => exception
      respond_to do |format|
        format.json { render json: { errors: [exception.message] }, status: :unprocessable_entity }
      end
      false
    end
  end

  def set_kalibro_range
    begin
      @kalibro_range = KalibroRange.find(params[:id].to_i)
      true
    rescue ActiveRecord::RecordNotFound => exception
      respond_to do |format|
        format.json { render json: { errors: [exception.message] }, status: :unprocessable_entity }
      end
      false
    end
  end

  def kalibro_range_params
    params.require(:kalibro_range).permit(:beginning, :end, :comments, :reading_id, :metric_configuration_id)
  end

  def convert(value)
    if value == "INF"
      return Float::INFINITY
    elsif value == "-INF"
      return -Float::INFINITY
    end
    return value
  end

  def set_interval_params
    params[:kalibro_range][:beginning] = convert(params[:kalibro_range][:beginning])
    params[:kalibro_range][:end] = convert(params[:kalibro_range][:end])
  end

  def json_conversion(range)
    # JSON does not understand Infinity. That's why we have to make this series of conversions.
    hash = range.attributes
    hash["beginning"] = range.beginning.to_s if range.beginning == -Float::INFINITY
    hash["end"] = range.end.to_s if range.end == Float::INFINITY
    return hash
  end
end
