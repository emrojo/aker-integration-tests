###
# Specific submission actions
###

Given(/^I go to the Dispatch Labware$/) do
  visit "#{@submission_url}/completed_submissions"
  step("I should see \"Dispatch Labware\"")
  step("I save a screenshot")
end

Given(/^I go to the Material Reception$/) do
  visit "#{@submission_url}/material_receptions"
  step("I should see \"Material Reception\"")
  step("I save a screenshot")
end

Given(/^I go to check the contents of the submission created before$/) do
  visit "#{@submission_url}/material_submissions/#{@submission}"
  step("I should see \"Material Submission\"")
  step("I save a screenshot")
end

Given(/^I select a type of labware$/) do
  first("input[name=\"material_submission[labware_type_id]\"]").set(true)
end

Given(/^I want to create (\d+) labware$/) do |arg1|
  fill_in('How many plates or tubes', :with => arg1)
end

When(/^I upload the file "([^"]*)"$/) do |arg1|
  attach_file('Upload CSV', File.absolute_path(arg1), make_visible: true)
  step("I save a screenshot")
end

Then(/^I will know the barcodes of the labware I created for the submission$/) do
  @barcodes = all('table tr td:first-child').map(&:text).uniq
  puts "The submission #{@submission} contains the following different barcodes:"
  @barcodes.each do |barcode|
    puts "  - #{barcode}"
  end
end

Given(/^I scan one by one the barcodes from the previous submission$/) do
  @barcodes.each do |barcode|
    puts "I'll try scanning barcode #{barcode}"

    # Poltergeist is not compatible with '\n' as a way to indicate the key 'enter' from
    # the user, so in order to emulate scanning the barcode an receiving 'enter' we need to call
    # the native key event
    field = find(:fillable_field, "Scan a barcode")
    field.set("#{barcode}")
    field.send_keys(:enter)
    step("I should see \"Barcode scanned\"")
  end
  step("I save a screenshot")  
end

Given(/^I print the submission created before$/) do
  puts "I'm going to print the submission #{@submission}"
  first("input[value='#{@submission}']").set(true)
  first("input[value='Print']").click
end

Given(/^I dispatch the submission created before$/) do
  puts "I'm going to dispatch the submission #{@submission}"
  first("input[value='#{@submission}']").set(true)
  first("input[value='Dispatch']").click
end

Given(/^I go to next screen$/) do
  within(first('form > .row > .col-md-12')) { click_on('Next') }
end

Then(/^I am in "([^"]*)"$/) do |arg1|
  expect(page).to have_content(arg1)
  step("I save a screenshot")
end


Then(/^I should see data from my file like a textbox containing "([^"]*)"$/) do |arg1|
  expect(page).to have_selector("input[value='" + arg1 + "']")
end

Then(/^I should see data from my file like a dropdown with "([^"]*)" selected$/) do |arg1|
  expect(page).to have_selector("select[value='" + arg1 + "']")
end

Then(/^I should see validation errors$/) do
  expect(page).to have_content('validation')
end

Then(/^I should not see any validation errors$/) do
  expect(page).not_to have_content('validation')
end

When(/^I enter my details as collaborator$/) do
  fill_in('Address', with: 'Some address')
end

Then(/^I know my shared submission identifier$/) do
  expect(page.text).to match(/Submission (\d+)/)
  @submission = page.text.match(/Submission (\d+)/).captures[0]
  puts "Your submission is #{@submission}"
end

Given(/^I select the Sanger Sample Guardian previously defined$/) do
  step("I select \"#{@sample_guardian}\" from the \"Sanger Sample Guardian\" select")
end

