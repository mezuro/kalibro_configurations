FactoryGirl.define do
  factory :metric_configuration do
    id 1
    metric_id 1
    weight 1.5
    aggregation_form "MyString"
    reading_group_id 1
    configuration_id 1
  end

end
