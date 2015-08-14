Given(/^I have a Metric Configuration$/) do
  @metric_configuration = FactoryGirl.create(:metric_configuration)
end

Given(/^I have a Reading$/) do
  @reading = FactoryGirl.create(:reading)
end

Given(/^I have a Range from "(.*?)" to "(.*?)"$/) do |beginning, end_|
  KalibroRange.create!(beginning: beginning, end: end_,
                       metric_configuration: @metric_configuration,
                       reading: @reading)
end

When(/^I create a Range from "(.*?)" to "(.*?)"$/) do |beginning, end_|
  @range = KalibroRange.create(beginning: beginning, end: end_,
                               metric_configuration: @metric_configuration,
                               reading: @reading)
end

Then(/^I should get a validation error for "(.*?)"$/) do |attribute|
  expect(@range.errors).to include(attribute.to_sym)
end

Then(/^the Range should not have been saved$/) do
  expect(@range.persisted?).to be_falsy
end
