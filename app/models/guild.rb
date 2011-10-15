class Guild < ActiveRecord::Base
  has_many :characters

  default_scope order('achievement_points DESC')
  scope :rank, select("*, row_number() OVER (ORDER BY achievement_points DESC) AS rank")
  
  validates :region, :realm, :name, :presence => true
  validates :region, :inclusion => { :in => %w(us eu kr tw)}
end
