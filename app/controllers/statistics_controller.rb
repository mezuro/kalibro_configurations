class StatisticsController < ApplicationController
  def count_metric_configuration
  	metric_configuration = MetricConfiguration.all
  	
  	count_metric_name = Hash.new(0)
  	metric_configuration.each { |x|  count_metric_name[x.metric_snapshot.name]+=1 }

    respond_to do |format|
     	format.json {render json: {count_metric_name: count_metric_name}
     end
  end

end

