FactoryGirl.define do
  factory :metric_configuration do
    metric_snapshot { FactoryGirl.build(:metric_snapshot) }
    kalibro_configuration { FactoryGirl.build(:kalibro_configuration) }

    trait :with_id do
      id 33
    end

    factory :metric_configuration_with_id, traits: [:with_id]
  end
end
