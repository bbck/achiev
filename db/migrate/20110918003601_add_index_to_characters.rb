class AddIndexToCharacters < ActiveRecord::Migration
  def change
    add_index :characters, :guild_id
  end
end
