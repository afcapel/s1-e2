require 'test_helper'

class UserTest < Test::Unit::TestCase
  test "a user can have commits" do
    
    user = User.new(:username => 'paco')
    
    1.upto(10) do |i|
      user.commits << Commit.new(:message => "Commit #{i}")
    end
    
    user.save!
    
    assert user.commits.size == 10
  end
end
