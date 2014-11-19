FactoryGirl.define do
  factory :kalibro_range do
    id 1
    beginning 0.5
    self.end 1.5
    comments "Range comments"
    reading { FactoryGirl.build(:reading) }
    metric_configuration { FactoryGirl.build(:metric_configuration) }
  end
end
