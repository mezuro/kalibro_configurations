FactoryGirl.define do
  factory :compound_metric_snapshot do
    type "CompoundMetricSnapshot"
    name "Lines of Code"
    description ""
    code "loc"
    scope "CLASS"
    script "return 0;"
  end
end