class Guild < ActiveRecord::Base
  
  has_many :characters
  
  default_scope order('achievement_points DESC')
end
