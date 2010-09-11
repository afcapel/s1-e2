require 'rubygems'
require "bundler/setup"

require 'active_record'
require 'yaml'

dbconfig = YAML::load(File.open('config/database.yml'))
ActiveRecord::Base.establish_connection(dbconfig)
ActiveRecord::Migrator.up('db/migrate')

# require all models
Dir["#{File.dirname(__FILE__)}/model/*.rb"].each {|file| require file }

