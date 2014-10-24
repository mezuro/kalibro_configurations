class ReadingGroupsController < ApplicationController
  before_action :set_reading_group,  only: [:update, :destroy, :readings_of]

  def all
    reading_groups = {reading_groups: ReadingGroup.all}

    respond_to do |format|
      format.json { render json: reading_groups }
    end
  end

  def show
    begin
      set_reading_group
      response = {reading_group: @reading_group}
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
    reading_group = ReadingGroup.new(reading_group_params)

    respond_to do |format|
      if reading_group.save
        format.json { render json: {reading_group: reading_group} , status: :created }
      else
        format.json { render json: {reading_group: reading_group} , status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @reading_group.update(reading_group_params)
        format.json { render json: {reading_group: @reading_group} , status: :created }
      else
        format.json { render json: {reading_group: @reading_group} , status: :unprocessable_entity }
      end
    end
  end

  def exists
    respond_to do |format|
      format.json { render json: {exists: ReadingGroup.exists?(params[:id].to_i)} }
    end
  end

  def destroy
    @reading_group.destroy
    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
  end

  def readings_of
    respond_to do |format|
      format.json { render json: {readings: @reading_group.readings} }
    end
  end

  private
    def set_reading_group
      @reading_group = ReadingGroup.find(params[:id].to_i)
    end

    def reading_group_params
      params.require(:reading_group).permit(:name, :description)
    end
end
