class FiftyCommitsAchivement < StaticAchivement
  
  def self.should_be_achived_by?(user)
    user.commits.size >= 50
  end
  
  def message
    "Did her fifty commit!"
  end
end