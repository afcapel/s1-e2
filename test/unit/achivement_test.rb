require 'test_helper'

class AchivmentTest < ApplicationTest
  
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
  
  test "top ten commiters earn an achivement" do
    
    1.upto(20) do |i|
       user = User.new(:username => "user#{i}")
       1.upto(i) do |j|
         user.commits << Commit.new(:message => "Commit #{j}")
       end
      user.save!
    end
    
    Achivement.calculate_dynamic_achivements!
    
    User.top_ten_commiters.each do |commiter|
      assert commiter.already_achived?(TopTenCommiterAchivement), "Top ten commiter should earn an achivement"
    end
  end
  
  test "a user can loose her top ten commiter achivement" do
    
    1.upto(20) do |i|
       user = User.new(:username => "user#{i}")
       1.upto(i) do |j|
         user.commits << Commit.new(:message => "Commit #{j}")
       end
      user.save!
    end
    
    Achivement.calculate_dynamic_achivements!
    
    last_top_ten_commiter = User.top_ten_commiters.to_a.last
    
    assert last_top_ten_commiter.already_achived?(TopTenCommiterAchivement), "Last top ten commiter should earn an achivement"
    
    new_top_ten_committer = User.new(:username => "new_top_ten_commiter")
    
    1.upto(30) do |k|
      new_top_ten_committer.commits << Commit.new(:message => "Commit #{k}")
    end
    
    new_top_ten_committer.save!
    
    Achivement.calculate_dynamic_achivements!
    
    last_top_ten_commiter.reload
    
    assert ! last_top_ten_commiter.already_achived?(TopTenCommiterAchivement), "Last top ten commiter should have lost her achivement"
    
  end
end
