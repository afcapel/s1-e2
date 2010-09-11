class FirstCommitAchivement < StaticAchivement
  
  def self.should_be_achived_by?(user)
    user.commits.size > 0
  end
  
  def message
    "Did her first commit!"
  end
end