class KalibroRange < ActiveRecord::Base
  belongs_to :reading
  belongs_to :metric_configuration

end
