require 'environment'
require "test/unit"
require "contest"
require "factory"

class ApplicationTest < Test::Unit::TestCase
  include Factories
  #truncate tables before test
  setup do
    ActiveRecord::Base.connection.tables.each do |table|
      ActiveRecord::Base.connection.execute("DELETE FROM #{table}")
      ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence where name='#{table}'")
    end
  end
end



