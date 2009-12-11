RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION
require File.join(File.dirname(__FILE__), 'boot')
$KCODE='UTF8'
Rails::Initializer.run do |config|
  config.gem "formtastic", :version => ">=0.9.4", :source => 'http://gemcutter.org'
  config.gem "simple-navigation", :lib => "simple_navigation", :source => "http://gemcutter.org"
  config.gem "will_paginate"
  config.gem "nokogiri"
  config.time_zone = 'UTC'
end