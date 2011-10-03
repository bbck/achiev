class Character < ActiveRecord::Base
  belongs_to :guild,
             :counter_cache => true

  default_scope order('achievement_points DESC')
  scope :rank, select("*, row_number() OVER (ORDER BY achievement_points DESC) AS rank")
end
