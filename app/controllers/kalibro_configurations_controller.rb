class KalibroConfigurationsController < ApplicationController
  before_action :set_kalibro_configuration, except: [:all, :show, :create, :exists]

  def all
    kalibro_configurations = {kalibro_configurations: KalibroConfiguration.all}

    respond_to do |format|
      format.json { render json: kalibro_configurations }
    end
  end

  def show
    begin
      set_kalibro_configuration
      response = {kalibro_configuration: @kalibro_configuration}
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
    kalibro_configuration = KalibroConfiguration.new(kalibro_configuration_params)

    respond_to do |format|
      if kalibro_configuration.save
        format.json { render json: {kalibro_configuration: kalibro_configuration} , status: :created }
      else
        format.json { render json: {kalibro_configuration: kalibro_configuration} , status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @kalibro_configuration.update(kalibro_configuration_params)
        format.json { render json: {kalibro_configuration: @kalibro_configuration} , status: :created }
      else
        format.json { render json: {kalibro_configuration: @kalibro_configuration} , status: :unprocessable_entity }
      end
    end
  end

  def exists
    respond_to do |format|
      format.json { render json: {exists: KalibroConfiguration.exists?(params[:id].to_i)} }
    end
  end

  def metric_configurations_of
    metric_configurations = KalibroConfiguration.metric_configurations_of(params[:id].to_i)
    respond_to do |format|
      format.json { render json: {metric_configurations: metric_configurations} }
    end
  end

  def destroy
    @kalibro_configuration.destroy
    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
  end

  private
    def set_kalibro_configuration
      @kalibro_configuration = KalibroConfiguration.find(params[:id].to_i)
    end

    def kalibro_configuration_params
      params.require(:kalibro_configuration).permit(:name, :description)
    end
end
