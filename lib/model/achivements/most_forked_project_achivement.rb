class MostForkedProjectAchivement < DynamicAchivement
  
  def self.grant_to_users
    
    ActiveRecord::Base.transaction do
      
      most_forked_project = Project.most_forked
      
      unless most_forked_project.nil? || most_forked_project.user.already_achived?(MostForkedProjectAchivement)
        Achivement.delete_all(:type => "MostForkedProjectAchivement")
        most_forked_project.user.achivements << MostForkedProjectAchivement.new
        most_forked_project.user.save!
      end
      
    end
  end
  
  def message
    "Author of the most forked project!"
  end
  
end