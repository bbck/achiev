class CreateCharacters < ActiveRecord::Migration
  def self.up
    create_table :characters do |t|
      t.string :region, :limit => 2
      t.string :realm
      t.string :name, :limit => 12
      t.string :battlegroup
      t.string :guild, :limit => 24
      t.integer :achievement_points
      t.integer :level
      t.integer :title_id
      t.integer :faction_id
      t.integer :race_id
      t.integer :class_id
      t.integer :gender_id

      t.timestamps
    end
    add_index :characters, [:region, :realm, :name], :unique => true
  end

  def self.down
    remove_index :characters, [:region, :realm, :name]
    drop_table :characters
  end
end
