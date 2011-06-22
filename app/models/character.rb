class Character < ActiveRecord::Base
  
  belongs_to :guild
  
  default_scope order('achievement_points DESC')
end
