module Factories
  
  def create_user(attrs = {})
    attrs[:username] ||= "user#{rand(1000)}"
    
    num_commits = attrs.delete(:num_commits) || 0
    user = User.new(attrs)
    
    1.upto(num_commits) do |i|
      user.commits << Commit.new(:message => "Commit #{i}")
    end
    
    user.save!
    user
  end
  
  def create_project(attrs = {})
    attrs[:user] ||= create_user
    project = Project.create(attrs)
  end
end
