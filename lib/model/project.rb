class Project < ActiveRecord::Base
  belongs_to :user
  belongs_to :forked_from, :class_name => 'Project', :inverse_of => :forks, :counter_cache => :forks_count
  has_many :forks, :class_name => 'Project', :inverse_of => :forked_from
  
  def self.most_forked
    order("forks_count DESC").first
  end
  
end