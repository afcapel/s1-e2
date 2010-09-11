class StaticAchivement < Achivement
  
  def self.should_be_achived_by?(user)
    raise Exception.new "You need to implement should_be_achived_by? method to create a StaticAchivement"
  end
end