class User < ActiveRecord::Base
  has_many :commits
  has_many :achivements

  before_save :earn_achivements

  def already_achived?(achivement)
    achivements.map{ |achiv| achiv.class }.include?(achivement)
  end
  
  def should_have_new_achivement?(achivement)
    ! already_achived?(achivement) && achivement.should_be_achived_by?(self)
  end
  
  def self.users_with_achivement(achivement)
    Achivement.find(:type => achivement.type).collect{ |a| a.user }
  end
  
  def self.top_ten_commiters
    User.order('commits_count DESC').limit(10)
  end
  
  private

  def earn_achivements
    Achivement.descendants.each do |achiv|
      if ! achiv.dynamic? && should_have_new_achivement?(achiv)
        self.achivements << achiv.new
      end
    end
  end

end