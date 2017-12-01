###
# Work order specific actions
###
Then(/^I know my work order identifier$/) do
  expect(page.text).to match(/Work order (\d+)/)
  @work_order_created = page.text.match(/Work order (\d+)/).captures[0]
  puts "Your work order is #{@work_order_created}"
end

Then(/^I should be on the step: "([^"]*)"$/) do |text|
  within(:css, "div.active") do
    expect(page.has_content?(text)).to eq(true)
  end
  step("I save a screenshot")
end

Then(/^I choose the submission created before$/) do
  step("I should see \"Submission #{@submission}\"")
  step("I choose \"Submission #{@submission}\" in a table")
end

Given(/^I click on drop-down "([^"]*)"$/) do |dropdown|
  find("##{dropdown}").click
end

Given(/^I click on "([^"]*)" in drop-down "([^"]*)"$/) do |value, dropdown|
  select "#{value}", from: "#{dropdown}"
end

When(/^I choose the project defined before$/) do
  step("I should see \"#{@project_defined}\"")
  step("I choose \"#{@project_defined}\"")
end

When(/^I choose the product defined before$/) do
  step("I click on drop-down \"product-select\"")
  step("I click on \"#{@product_defined}\" in drop-down \"product-select\"")
end

Then(/^I should see the project defined before$/) do
  step("I should see \"#{@project_defined}\"")
end

Then(/^I should see the product defined before$/) do
  step("I should see \"#{@product_defined}\"")
end
