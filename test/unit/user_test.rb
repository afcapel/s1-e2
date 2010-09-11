require 'test_helper'

class UserTest < ApplicationTest
  test "a user can have commits" do
    user = create_user(:num_commits => 10)
    assert user.commits.size == 10
  end
  
  test "search top ten commiters" do
    
    1.upto(20) do |i|
      create_user(:num_commits => i)
    end
    
    assert User.top_ten_commiters.size == 10
    
    User.top_ten_commiters.each do |commiter|
      assert commiter.commits_count > 10
    end
    
  end
end
