class ReadingsController < ApplicationController
  before_action :set_reading, only: [:update, :destroy]

  def show
    begin
      set_reading
      response = {reading: @reading}
      status = :ok
    rescue ActiveRecord::RecordNotFound
      response = {error: 'RecordNotFound'}
      status = :unprocessable_entity
    end

    respond_to do |format|
      format.json { render json: response, status: status }
    end
  end

  def create
    reading = Reading.new(reading_params)
    reading.reading_group_id = params[:reading_group_id]

    respond_to do |format|
      if reading.save
        format.json { render json: {reading: reading}, status: :created }
      else
        format.json { render json: {reading: reading}, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @reading.update(reading_params)
        format.json { render json: {reading: @reading}, status: :created }
      else
        format.json { render json: {reading: @reading}, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @reading.destroy
    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
  end

  private
    def set_reading
      @reading = Reading.find(params[:id].to_i)
    end

    def reading_params
      params.require(:reading).permit(:label, :grade, :color, :reading_group_id)
    end
end
