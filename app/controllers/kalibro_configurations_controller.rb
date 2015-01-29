class KalibroConfigurationsController < ApplicationController
  def all
    kalibro_configurations = {kalibro_configurations: KalibroConfiguration.all}

    respond_to do |format|
      format.json { render json: kalibro_configurations }
    end
  end

  def show
    if set_kalibro_configuration
      respond_to do |format|
        format.json { render json: {kalibro_configuration: @kalibro_configuration}, status: :ok }
      end
    end
  end

  def create
    kalibro_configuration = KalibroConfiguration.new(kalibro_configuration_params)

    respond_to do |format|
      if kalibro_configuration.save
        format.json { render json: {kalibro_configuration: kalibro_configuration}, status: :created }
      else
        format.json { render json: {errors: kalibro_configuration.errors.full_messages}, status: :unprocessable_entity }
      end
    end
  end

  def update
    if set_kalibro_configuration
      respond_to do |format|
        if @kalibro_configuration.update(kalibro_configuration_params)
          format.json { render json: {kalibro_configuration: @kalibro_configuration}, status: :created }
        else
          format.json { render json: {errors: @kalibro_configuration.errors.full_messages}, status: :unprocessable_entity }
        end
      end
    end
  end

  def exists
    respond_to do |format|
      format.json { render json: {exists: KalibroConfiguration.exists?(params[:id].to_i)} }
    end
  end

  def metric_configurations
    if set_kalibro_configuration
      respond_to do |format|
        format.json { render json: {metric_configurations: @kalibro_configuration.metric_configurations} }
      end
    end
  end

  def destroy
    if set_kalibro_configuration
      @kalibro_configuration.destroy
      respond_to do |format|
        format.json { render json: {}, status: :ok }
      end
    end
  end

  private

  def set_kalibro_configuration
    begin
      @kalibro_configuration = KalibroConfiguration.find(params[:id].to_i)
      true
    rescue ActiveRecord::RecordNotFound => exception
      respond_to do |format|
        format.json { render json: {errors: [exception.message]}, status: :unprocessable_entity }
      end
      false
    end
  end

  def kalibro_configuration_params
    params.require(:kalibro_configuration).permit(:name, :description)
  end
end
