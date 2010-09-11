class Achivement < ActiveRecord::Base
  belongs_to :user
  
  def message
    raise Exception.new "You need to implement message method to create an Achivement"
  end
  
  def self.dynamic?
    false
  end
        
end