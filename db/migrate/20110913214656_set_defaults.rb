class SetDefaults < ActiveRecord::Migration
  def change
    change_column_default :characters, :achievement_points, 0
    change_column_default :guilds, :achievement_points, 0
    change_column_default :guilds, :characters_count, 0
  end
end