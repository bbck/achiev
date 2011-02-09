class ChangeGuildInCharacter < ActiveRecord::Migration
  def self.up
    change_table(:characters) do |t|
      t.rename :guild, :guild_id
      t.change :guild_id, :integer
    end
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
