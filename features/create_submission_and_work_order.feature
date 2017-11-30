@javascript

Feature: Create a submission and work order

Because I am a collaborator working remotely
And I want to send samples to an internal contact at the institute
I want to to provide all the needed information required for my contact

Background:

Given I load all the configuration from my environmental .yml file

Scenario:

Given I go to the Submission application

And I click on "Create"
Then I am in "Container Type"
Given I select a type of labware
And I want to create 1 labware
And I click on "Next"

Then I am in "Biomaterial Metadata"
Given I upload the file "test/data/correct_manifest.csv"
Then I should see data from my file like a textbox containing "334457"
And I should see data from my file like a dropdown with "male" selected
And I should see data from my file like a textbox containing "Homo sapiens"

When I go to next screen
Then I should not see any validation errors
And I am in "Ethics"
When I check "I confirm that no HMDMC is required"
And I click on "Next"

Then I am in "Delivery Details"
Given I enter my details as collaborator
When I select the Sanger Sample Guardian previously defined
Then I know my shared submission identifier
Then I click on "Save"
Then I should see "Your submission has been created"

Given I go to the Dispatch Labware
Then I print the submission created before
Then I should see "Print issued"
Then I dispatch the submission created before
Then I should see "Submissions dispatched"

Given I go to check the contents of the submission created before
Then I will know the barcodes of the labware I created for the submission

Given I go to the Material Reception
And I scan one by one the barcodes from the previous submission

Given I go to the Work order application
When I click on "Create New Work Order"
Then I should be on the step: "Select Set"
Then I choose the submission created before
And I click on "Next"
Then I should be on the step: "Select Project"
When I choose the project defined before
And I click on "Next"
Then I should be on the step: "Select Product"
And I should see "Choose a product:"
When I choose the product defined before
And I click on "Next"

Then I should be on the step: "Confirm"
And I should see the project defined before
And I should see the product defined before
Then I know my work order identifier

When I click on "Save & Exit"
Then I should see "Your work order has been created"

Given I go to Sequencescape
When I go to the view for the previously created work order in Sequencescape
And I click on "Complete"

Then I should see "completed"
