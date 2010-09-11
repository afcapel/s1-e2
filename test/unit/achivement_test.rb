require 'test_helper'

class AchivmentTest < Test::Unit::TestCase
  
  test "achivemet keep track of its descendants" do
    assert Achivement.descendants.include? FirstCommitAchivement
  end
  
  test "a user earns an achivement after her first commit" do
    
    user = User.create(:username => 'pepe')
    
    assert !user.already_achived?(FirstCommitAchivement)
    
    user.commits << Commit.new(:message => "My first commit!")
    
    user.save!
    
    assert user.commits.size > 0
    assert user.achivements.size > 0, "User achivments must be greater than 0 after first commit"
    assert user.already_achived? FirstCommitAchivement
  end
  
  test "a user earns an achivement after her fifty commit" do
    
    user = User.create(:username => 'juana')
    
    1.upto(50) do |i|
      user.commits << Commit.new(:message => "commit #{i}")
    end
    
    user.save!
    
    assert user.commits.size == 50, "User should have 50 commits"
    assert user.already_achived?(FiftyCommitsAchivement), "User should have earned the 50 commits achivement"
  end
end
