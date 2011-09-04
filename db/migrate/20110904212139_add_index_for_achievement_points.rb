class AddIndexForAchievementPoints < ActiveRecord::Migration
  def up
    add_index :characters, :achievement_points
    add_index :guilds, :achievement_points
  end

  def down
    remove_index :characters, :achievement_points
    remove_index :guilds, :achievement_points
  end
end
