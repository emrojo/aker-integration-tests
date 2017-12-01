require 'capybara'
require 'capybara/cucumber'
require 'capybara/poltergeist'


require "selenium/webdriver"

require 'yaml'

Dir.mkdir 'screenshots' unless File.exists?('screenshots')

environment_file_path = ENV['INTEGRATION_TESTS_CONFIG']
unless environment_file_path && File.exists?(environment_file_path)
  puts "You need to specify the config file in INTEGRATION_TESTS_CONFIG environment variable."
  exit(1)
end

INTEGRATION_TESTS_CONFIG = YAML::load(File.open(environment_file_path))


unless INTEGRATION_TESTS_CONFIG['proxy']
  ENV['http_proxy']=''
  ENV['https_proxy']=''
  ENV['HTTP_PROXY']=''
end

Capybara.default_max_wait_time = INTEGRATION_TESTS_CONFIG['default_wait_time'] || 10

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

Capybara.register_driver :poltergeist_debug do |app|
  Capybara::Poltergeist::Driver.new(app, url_blacklist: ['https://fonts.googleapis.com'],
    timeout: INTEGRATION_TESTS_CONFIG['default_wait_time'],
    phantomjs_options: ['--ignore-ssl-errors']
    #js_errors: true, phantomjs_logger: STDOUT,
                     #phantomjs_options: ['--debug=true'],
    #                inspector: true
    )
end

Capybara.configure do |config|
  config.default_driver = INTEGRATION_TESTS_CONFIG['driver'].to_sym
end

Capybara.javascript_driver = INTEGRATION_TESTS_CONFIG['driver'].to_sym

World(Capybara)