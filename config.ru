require 'bundler'
Bundler.setup(:default)
require './slackruby.rb'
run Sinatra::Application
