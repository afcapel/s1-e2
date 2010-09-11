class FirstCommitAchivement < Achivement
  
  def self.should_be_achived_by?(user)
    user.commits.size > 0
  end
  
  def self.dynamic?
    false
  end
  
  def message
    "Did her first commit!"
  end
end