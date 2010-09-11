class Achivement < ActiveRecord::Base
  belongs_to :user
  
  def self.dynamic?
    false
  end
  
  def self.calculate_dynamic_achivements!
    Achivement.descendants.each do |achiv|
      achiv.grant_to_users if achiv.dynamic?
    end
  end
        
end