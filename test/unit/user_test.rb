require 'test_helper'

class UserTest < ApplicationTest
  test "a user can have commits" do
    user = User.new(:username => 'paco')
    
    1.upto(10) do |i|
      user.commits << Commit.new(:message => "Commit #{i}")
    end
    
    user.save!
    
    assert user.commits.size == 10
  end
  
  test "search top ten commiters" do
    
    1.upto(20) do |i|
       user = User.new(:username => "user#{i}")
       1.upto(i) do |j|
         user.commits << Commit.new(:message => "Commit #{j}")
       end
      user.save!
    end
    
    assert User.top_ten_commiters.size == 10
    
    User.top_ten_commiters.each do |commiter|
      assert commiter.commits_count > 10
    end
    
  end
end
