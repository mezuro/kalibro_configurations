FactoryGirl.define do
  factory :compound_metric do
    name "Attack Surface"
    description "How much of your can subject to attacks"
    code "atks"
    metric_collector_name ""
    scope "CLASS"
    script "return noa()/npa();"
  end
end
