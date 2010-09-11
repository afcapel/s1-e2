class User < ActiveRecord::Base
  has_many :commits
  has_many :achivements

  before_save :earn_achivements

  def already_achived?(achivement)
    achivements.map{ |achiv| achiv.class }.include?(achivement)
  end

  def earn_achivements
    Achivement.descendants.each do |achiv|
      if ! already_achived?(achiv) && achiv.should_be_achived_by?(self)
        self.achivements << achiv.new
      end
    end
  end

end