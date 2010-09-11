class TopTenCommiterAchivement < Achivement
  
  def self.dynamic?
    true
  end
  
  def self.grant_to_users
    
    ActiveRecord::Base.transaction do
      
      top_ten_commiters = User.top_ten_commiters
      old_top_ten_achivements = Achivement.find_all_by_type('TopTenCommiterAchivement')
      
      # Destroy old top ten achivments if the user is no longer in the top ten
      old_top_ten_achivements.each do |top_ten|
        top_ten.destroy unless top_ten_commiters.include? top_ten.user
      end
      
      #Save new top ten commiters
      top_ten_commiters.each do |commiter|
        unless old_top_ten_achivements.include? commiter
          commiter.achivements << TopTenCommiterAchivement.new
          commiter.save
        end
      end
      
    end
  end
  
  def message
    "Between the top ten commiters!"
  end
  
end