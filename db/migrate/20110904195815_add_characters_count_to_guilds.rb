class AddCharactersCountToGuilds < ActiveRecord::Migration
  def change
    add_column :guilds, :characters_count, :integer
  end
end
