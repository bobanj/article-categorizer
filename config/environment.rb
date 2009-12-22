RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION
require File.join(File.dirname(__FILE__), 'boot')
$KCODE='UTF8'
Rails::Initializer.run do |config|
  config.gem 'authlogic'
  config.gem 'will_paginate', :version => '~> 2.3.11', :source => 'http://gemcutter.org'
  config.gem "nokogiri"
  config.gem "formtastic"
  config.gem "haml"
  config.time_zone = 'UTC'
end