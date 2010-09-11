class TopTenCommiterAchivement < DynamicAchivement
  
  def self.grant_to_users
    
    ActiveRecord::Base.transaction do
      
      # Destroy old top ten commiters achivments
      Achivement.delete_all(:type => 'TopTenCommiterAchivement')
      
      #Save new top ten commiters
      User.top_ten_commiters.each do |commiter|
        commiter.achivements << TopTenCommiterAchivement.new
        commiter.save
      end
      
    end
  end
  
  def message
    "Between the top ten commiters!"
  end
  
end