class ReadingGroupsController < ApplicationController
  def all
    reading_groups = {reading_groups: ReadingGroup.all}

    respond_to do |format|
      format.json { render json: reading_groups }
    end
  end

  def show
    if set_reading_group
      respond_to do |format|
        format.json { render json: {reading_group: @reading_group}, status: :ok }
      end
    end
  end

  def create
    reading_group = ReadingGroup.new(reading_group_params)

    respond_to do |format|
      if reading_group.save
        format.json { render json: {reading_group: reading_group}, status: :created }
      else
        format.json { render json: {errors: reading_group.errors.full_messages}, status: :unprocessable_entity }
      end
    end
  end

  def update
    if set_reading_group
      respond_to do |format|
        if @reading_group.update(reading_group_params)
          format.json { render json: {reading_group: @reading_group}, status: :created }
        else
          format.json { render json: {errors: @reading_group.errors.full_messages}, status: :unprocessable_entity }
        end
      end
    end
  end

  def exists
    respond_to do |format|
      format.json { render json: {exists: ReadingGroup.exists?(params[:id].to_i)} }
    end
  end

  def destroy
    if set_reading_group
      @reading_group.destroy
      respond_to do |format|
        format.json { render json: {}, status: :ok }
      end
    end
  end

  private

    def set_reading_group
      begin
        @reading_group = ReadingGroup.find(params[:id].to_i)
        true
      rescue ActiveRecord::RecordNotFound => exception
        respond_to do |format|
          format.json { render json: {errors: [exception.message]}, status: :unprocessable_entity }
        end
        false
      end
    end

    def reading_group_params
      params.require(:reading_group).permit(:name, :description)
    end
end
