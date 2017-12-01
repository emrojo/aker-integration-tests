# encoding: utf-8

###
# General browser actions
###

After do |scenario|
  if (scenario.failed?)
    page.driver.save_screenshot("screenshots/#{scenario.__id__}.png")
    embed("screenshots/#{scenario.__id__}.png", "image/png", "SCREENSHOT")
  end
end

Given(/^I go to Sequencescape$/) do
  visit @sequencescape_url
  step("I save a screenshot")
end

Given(/^I go to the Submission application$/) do
  visit @submission_url
  step("I am logged in")
  step("I save a screenshot")
end

Given(/^I go to the Work order application$/) do
  visit @work_order_url
  step("I am logged in")
  step("I should see \"Work Orders\"")
  step("I save a screenshot")
end

When(/^I should see a modal with the text "([^"]*)"$/) do |text|
  sleep 3
  step("I should see \"#{text}\"")
end

Given(/^I click on "([^"]*)"$/) do |arg1|
  click_on(arg1)
end

Given(/^I expect some from user input$/) do
  STDIN.read
end

Given(/^I check "([^"]*)"$/) do |arg1|
  check(arg1)
end

Given(/^I debug$/) do 
  binding.pry
end

Then(/^show me the page$/) do
  save_and_open_page
end

Then(/^I save a screenshot$/) do
  timestamp =Time.now.strftime("%Y-%m-%d-%H:%M:%s")
  file_str = "screenshots/#{timestamp}.png"
  page.driver.save_screenshot(file_str)
  embed(file_str, "image/png", "SCREENSHOT")  
end

When(/^I select "([^"]*)" from the "([^"]*)" select$/) do |option, dropdown|
  select(option, from: dropdown)
end

Then(/^I should see "([^"]*)"$/) do |arg1|
  expect(page).to have_content(arg1)
end

# Find a select box by (label) name or id and assert the given text is selected
Then(/^"([^"]*)" should be selected for "([^"]*)"$/) do |selected_text, dropdown|
  expect(page).to have_select(dropdown, selected: selected_text)
end

# Find a select box by (label) name or id and assert the expected option is present
Then(/^"([^"]*)" should contain "([^"]*)"$/) do |dropdown, text|
  expect(page).to have_select(dropdown, with_options: [text])
end

# Find the table by name or id and assert the given amount of rows are present in it's body
Then(/^"([^"]*)" should contain (\d+) rows$/) do |table, rows|
  page.all('table#' + table + ' tbody tr').count.should == rows
end

When(/^I choose "([^"]*)"$/) do |text|
  choose(text)
end

When(/^I choose "([^"]*)" in a table$/) do |text|
  page.find('tr', text: text).find('input').click
end
