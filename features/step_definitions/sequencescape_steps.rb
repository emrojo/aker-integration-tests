###
# Sequencescape specific actions
###

Given(/^I go to the view for the previously created work order in Sequencescape$/) do
  click_on("Work order #{@work_order_created}")
end

Given(/^I use Sequencescape to complete the work order created$/) do
  step("I go to Sequencescape")
  step("I go to the view for the previously created work order in Sequencescape")
  step("I click on \"Complete\"")
  step("I should see \"completed\"")
end
