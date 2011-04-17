class CharacterJob
  @queue = :character
  
  ATTRIBUTES = {
    :realm => "realm",
    :name => "name",
    :battlegroup => "battle_group",
    :achievement_points => "points",
    :level => "level",
    :title_id => "title_id",
    :faction_id => "faction_id",
    :race_id => "race_id",
    :class_id => "class_id",
    :gender_id => "gender_id",
  }
  
  def self.perform(region, realm, name)
    character = Character.find_by_region_and_realm_and_name(region, realm, name)
    character ||= Character.new
    
    return unless character.updated_at == nil || self.stale?(character.updated_at)
    
    # Basic info
    armory = self.character_from_armory(region, realm, name)
    if armory == nil
      character.destroy
      return
    end
    
    # We need to set the region by hand
    character.region = region
    
    ATTRIBUTES.each do |key, value|
      character[key] = armory.instance_variable_get("@#{value}")
    end
    
    # Guild
    if !armory.guild.blank?
      guild = Guild.find_by_region_and_realm_and_name(region, realm, armory.guild)
      guild ||= Guild.new
      if guild.id.nil?
        guild.region      = region
        guild.realm       = armory.realm
        guild.name        = armory.guild
        guild.battlegroup = armory.battle_group
        guild.faction_id  = armory.faction_id
        guild.save
        Resque.enqueue(GuildJob, region, realm, armory.guild)
      end
      character.guild = guild
    else
      character.guild = nil
    end
    
    character.save
    
    # Find any new characters in arena teams
    members = []
    armory.arena_teams.each do |team|
      team.members.each do |member|
        members << member.name unless member.name == armory.name || members.include?(member.name)
      end
    end
    if members.size > 0
      known = Character.find_all_by_region_and_realm_and_name(region, realm, members)
      known.each do |character|
        members.delete(character.name)
      end
      members.each do |member|
        Resque.enqueue(CharacterJob, region, realm, member)
      end
    end
    
    sleep 2
  end
  
  def self.character_from_armory(region, realm, name)
    begin
      armory = Armory.character_sheet(region, realm, name)
    rescue Armory::NotFound
      return nil
    end
  end
  
  def self.stale?(timestamp)
    timestamp < 3.days.ago
  end
end
