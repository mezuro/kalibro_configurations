class ReadingsController < ApplicationController
  def index
    if set_reading_group
      respond_to do |format|
        format.json { render json: {readings: @reading_group.readings} }
      end
    end
  end

  def show
    if set_reading
      respond_to do |format|
        format.json { render json: {reading: @reading}, status: :ok }
      end
    end
  end

  def exists
    respond_to do |format|
      format.json { render json: {exists: Reading.exists?(params[:id].to_i)} }
    end
  end

  def create
    reading = Reading.new(reading_params)
    reading.reading_group_id = params[:reading_group_id]

    respond_to do |format|
      if reading.save
        format.json { render json: {reading: reading}, status: :created }
      else
        format.json { render json: {errors: reading.errors.full_messages}, status: :unprocessable_entity }
      end
    end
  end

  def update
    if set_reading
      respond_to do |format|
        if @reading.update(reading_params)
          format.json { render json: {reading: @reading}, status: :created }
        else
          format.json { render json: {errors: @reading.errors.full_messages}, status: :unprocessable_entity }
        end
      end
    end
  end

  def destroy
    if set_reading
      @reading.destroy
      respond_to do |format|
        format.json { render json: {}, status: :ok }
      end
    end
  end

  private

  def set_reading_group
    begin
      @reading_group = ReadingGroup.find(params[:reading_group_id].to_i)
      true
    rescue ActiveRecord::RecordNotFound => exception
      respond_to do |format|
        format.json { render json: {errors: [exception.message]}, status: :unprocessable_entity }
      end
      false
    end
  end

  def set_reading
    begin
      @reading = Reading.find(params[:id].to_i)
      true
    rescue ActiveRecord::RecordNotFound => exception
      respond_to do |format|
        format.json { render json: {errors: [exception.message]}, status: :unprocessable_entity }
      end
      false
    end
  end

  def reading_params
    params.require(:reading).permit(:label, :grade, :color, :reading_group_id)
  end
end
