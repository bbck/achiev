class Character < ActiveRecord::Base
  
  belongs_to :guild,
             :counter_cache => true
  
  default_scope order('achievement_points DESC')
end
