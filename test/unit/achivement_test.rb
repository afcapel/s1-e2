require 'test_helper'

class AchivmentTest < ApplicationTest
  
  test "achivemet keep track of its descendants" do
    assert Achivement.descendants.include? FirstCommitAchivement
    assert StaticAchivement.descendants.include? FirstCommitAchivement
    assert ! DynamicAchivement.descendants.include?(FirstCommitAchivement)
  end
  
  test "a user earns an achivement after her first commit" do
    
    user = create_user(:num_commits => 1)
    
    assert user.commits.size > 0
    assert user.achivements.size > 0, "User achivments must be greater than 0 after first commit"
    assert user.already_achived? FirstCommitAchivement
  end
  
  test "a user earns an achivement after her fifty commit" do
    
    user = create_user(:num_commits => 50)
    
    assert user.commits.size == 50, "User should have 50 commits"
    assert user.already_achived?(FiftyCommitsAchivement), "User should have earned the 50 commits achivement"
  end
  
  test "top ten commiters earn an achivement" do
    
    1.upto(20) do |i|
      create_user(:num_commits => i)
    end
    
    DynamicAchivement.calculate_dynamic_achivements!
    
    User.top_ten_commiters.each do |commiter|
      assert commiter.already_achived?(TopTenCommiterAchivement), "Top ten commiter should earn an achivement"
    end
  end
  
  test "a user can loose her top ten commiter achivement" do
    
    1.upto(10) do |i|
      create_user(:num_commits => 5)
    end
    
    DynamicAchivement.calculate_dynamic_achivements!
    
    last_top_ten_commiter = User.top_ten_commiters.to_a.last
    
    assert last_top_ten_commiter.already_achived?(TopTenCommiterAchivement), "Last top ten commiter should earn an achivement"
    
    new_top_ten_committer = create_user(:num_commits => 10)
    
    DynamicAchivement.calculate_dynamic_achivements!
    
    last_top_ten_commiter.reload
    
    assert ! last_top_ten_commiter.already_achived?(TopTenCommiterAchivement), "Last top ten commiter should have lost her achivement"
    
  end
  
  test "a user can earn a most forked project achivement" do
    
    project = create_project
    
    1.upto(5) do
      other_user = create_user
      other_user.fork_project(project)
    end
    
    DynamicAchivement.calculate_dynamic_achivements!
    
    project.user.already_achived?(MostForkedProjectAchivement)
    
  end
end
