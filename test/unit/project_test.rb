require 'test_helper'

class ProjectTest < ApplicationTest
  test "a project can be forked" do
    project = create_project
    other_user = create_user
    
    project.forks_count == 0
    
    fork = other_user.fork_project(project)
    assert fork.user_id == other_user.id
    assert fork.forked_from_id == project.id
    assert fork.id != project.id
    
    assert project.forks_count == 1
  end
end