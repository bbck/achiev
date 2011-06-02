class AddFetchedAtToGuilds < ActiveRecord::Migration
  def self.up
    add_column :guilds, :fetched_at, :datetime
  end

  def self.down
    remove_column :guilds, :fetched_at
  end
end
