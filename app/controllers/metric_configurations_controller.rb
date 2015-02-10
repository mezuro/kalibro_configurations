class MetricConfigurationsController < ApplicationController

  def exists
    respond_to do |format|
      format.json { render json: {exists: MetricConfiguration.exists?(params[:id].to_i)} }
    end
  end

  def create
    metric_configuration_params = all_params

    metric_snapshot = build_metric_snapshot
    metric_configuration_params.delete('metric')
    @metric_configuration = MetricConfiguration.new(metric_configuration_params)
    if !metric_snapshot.id.nil? && @metric_configuration.valid_metric_snapshot_code?(metric_snapshot.code)

      @metric_configuration.metric_snapshot = metric_snapshot

      respond_to do |format|
        if @metric_configuration.errors.empty? && @metric_configuration.save
          format.json { render json: {metric_configuration: @metric_configuration}, status: :created}
        else
          format.json { render json: {errors: @metric_configuration.errors.full_messages + metric_snapshot.errors.full_messages}, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.json { render json: {errors: @metric_configuration.errors.full_messages + metric_snapshot.errors.full_messages}, status: :unprocessable_entity }
      end
    end
  end

  def update
    if set_metric_configuration
      metric_configuration_params = all_params
      metric_snapshot = @metric_configuration.metric_snapshot

      if !metric_configuration_params['metric'].nil? && metric_configuration_params['metric']['type'] == 'CompoundMetricSnapshot'
        metric_snapshot = build_metric_snapshot
        if metric_snapshot.errors.empty? && @metric_configuration.valid_metric_snapshot_code?(metric_snapshot.code)
          @metric_configuration.metric_snapshot.destroy
          @metric_configuration.metric_snapshot = metric_snapshot
          @metric_configuration.save
        end
      end

      metric_configuration_params.delete('metric')

      respond_to do |format|
        if @metric_configuration.errors.empty? && @metric_configuration.update(metric_configuration_params)
          format.json { render json: {metric_configuration: @metric_configuration}, status: :created}
        else
          format.json { render json: {errors: @metric_configuration.errors.full_messages + metric_snapshot.errors.full_messages}, status: :unprocessable_entity }
        end
      end
    end
  end

  def destroy
    if set_metric_configuration
      @metric_configuration.destroy

      respond_to do |format|
        format.json { render json: {}, status: :ok}
      end
    end
  end

  def show
    if set_metric_configuration
      respond_to do |format|
        format.json { render json: {metric_configuration: @metric_configuration}, status: :ok}
      end
    end
  end

  private

  def set_metric_configuration
    begin
      @metric_configuration = MetricConfiguration.find(params[:id].to_i)
      true
    rescue ActiveRecord::RecordNotFound => exception
      respond_to do |format|
        format.json { render json: { errors: [exception.message] }, status: :unprocessable_entity }
      end
      false
    end
  end

  def build_metric_snapshot
    MetricSnapshot.create(metric_params)
  end

  def metric_params
    all_params['metric']
  end

  def all_params
    params.require(:metric_configuration).permit(:weight, :aggregation_form, :reading_group_id, :kalibro_configuration_id, metric: [:script, :description, :scope, :name, :type, :metric_collector_name, :code, :languages])
  end
end
