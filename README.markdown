# Aker Integration Tests

## Introduction

Bundle of feature tests for Aker to be able to execute integration tests in local and staging

## Configuration

You need to create a YAML config file with the following options:

<dl>
<dt>driver</dt> <dd>Browser driver to use. Supported drivers are poltergeist_debug (headless) and chrome</dd>
<dt>proxy</dt> <dd>Specify if we want to use the proxy during the execution. Set it to true or false</dd>
<dt>perform_login</dt> <dd>wether we want to perform the Aker login process at the beginning. Set it to true or false</dd>
<dt>submission_url</dt> <dd>URL for the Aker submission service</dd>
<dt>work_order_url</dt> <dd>URL for the Aker work order service</dd>
<dt>sequencescape_url</dt> <dd>URL for Sequencescape</dd>
<dt>sanger_sample_guardian</dt> <dd>Email to select as sanger sample guardian during submission creation</dd>
<dt>project_name</dt> <dd>the name of the project we want to select during work order creation</dd>
<dt>product_name</dt> <dd>name of the product we want to select during work order creation</dd>
</dl>

A example for config file named `config/local.yml` for running the tests in localhost could be:

```
driver: chrome
proxy: false
perform_login: false
submission_url: http://localhost:9200
work_order_url: http://localhost:9300
sequencescape_url: http://localhost:9400
project_name: testing project
product_name: testing_product
sanger_sample_guardian: mymail@mail
```

## How to run it

* Start all services for Aker to test

* Run the integration tests:

```
bundle install
INTEGRATION_TESTS_CONFIG=config/local.yml bundle exec cucumber 
```
