require 'bundler'
Bundler.require

configure { enable :cross_origin }
require './app'
run Sinatra::Application
