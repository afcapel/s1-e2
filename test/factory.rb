module Factories
  
  def create_user(attrs = {})
    attrs[:username] ||= "user#{rand(1000)}"
    
    num_commits = attrs.delete(:num_commits) || 1
    user = User.new(attrs)
    
    1.upto(num_commits) do |i|
      user.commits << Commit.new(:message => "Commit #{i}")
    end
    
    user.save!
    user
  end
end
