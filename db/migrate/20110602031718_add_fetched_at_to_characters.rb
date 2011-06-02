class AddFetchedAtToCharacters < ActiveRecord::Migration
  def self.up
    add_column :characters, :fetched_at, :datetime
  end

  def self.down
    remove_column :characters, :fetched_at
  end
end
