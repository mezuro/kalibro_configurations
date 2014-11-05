FactoryGirl.define do
  factory :metric_configuration do
    id 1
    weight 1.5
    aggregation_form "MyString"
    reading_group_id 1
    metric_snapshot { FactoryGirl.build(:metric_snapshot) }
    kalibro_configuration { FactoryGirl.build(:kalibro_configuration) }
  end

end
