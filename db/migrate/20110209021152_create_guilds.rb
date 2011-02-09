class CreateGuilds < ActiveRecord::Migration
  def self.up
    create_table :guilds do |t|
      t.string :region, :limit => 2
      t.string :realm
      t.string :name, :limit => 24
      t.string :battlegroup
      t.integer :level
      t.integer :achievement_points
      t.integer :faction_id

      t.timestamps
    end
    add_index :guilds, [:region, :realm, :name], :unique => true
  end

  def self.down
    remove_index :guilds, [:region, :realm, :name]
    drop_table :guilds
  end
end
