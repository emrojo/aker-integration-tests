###
# Config definition
###
Given(/^I load all the configuration from my environmental .yml file$/) do
  step("the url for submission is \"#{INTEGRATION_TESTS_CONFIG['submission_url']}\"")
  step("the url for work order is \"#{INTEGRATION_TESTS_CONFIG['work_order_url']}\"")
  step("the url for sequencescape is \"#{INTEGRATION_TESTS_CONFIG['sequencescape_url']}\"")
  step("the project I will use is \"#{INTEGRATION_TESTS_CONFIG['project_name']}\"")
  step("the product I will use is \"#{INTEGRATION_TESTS_CONFIG['product_name']}\"")
  step("the Sanger Sample Guardian is \"#{INTEGRATION_TESTS_CONFIG['sanger_sample_guardian']}\"")
end

Given(/^the url for submission is "([^"]*)"$/) do |url|
  @submission_url = url
end

Given(/^the url for work order is "([^"]*)"$/) do |url|
  @work_order_url = url
end

Given(/^the url for sequencescape is "([^"]*)"$/) do |url|
  @sequencescape_url = url
end

Given(/^the Sanger Sample Guardian is "([^"]*)"$/) do |mail|
  @sample_guardian = mail
end

Given(/^the project I will use is "([^"]*)"$/) do |proj|
  @project_defined = proj
end

Given(/^the product I will use is "([^"]*)"$/) do |prod|
  @product_defined = prod
end

Given(/^I am logged in$/) do
  if INTEGRATION_TESTS_CONFIG['perform_login']
    if page.has_content?("Aker Log in")
      fill_in("Username/Email", with: ENV['AKER_USERNAME'])
      fill_in("Password", with: ENV['AKER_PASSWORD'])
      click_on('Log in')
    end
  end
end
