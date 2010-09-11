class DynamicAchivement < Achivement
    
  def self.calculate_dynamic_achivements!
    DynamicAchivement.descendants.each do |achiv|
      achiv.grant_to_users
    end
  end
  
end