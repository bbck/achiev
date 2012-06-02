class GuildJob
  extend JobHelpers
  extend FailedHooks
  
  @queue = :guild
  
  def self.perform(region, realm, name)
    guild = Guild.find_by_region_and_realm_and_name(region, realm, name)
    guild ||= Guild.new
    
    return unless guild.fetched_at == nil || needs_update?(guild.fetched_at)
    
    armory = guild_from_armory(region, realm, name)
    
    guild.region = region
    guild.fetched_at = Time.now
    guild.name = armory["name"]
    guild.realm = armory["realm"]
    guild.faction_id = armory["side"]
    guild.level = armory["level"]
    guild.achievement_points = armory["achievementPoints"]
    
    guild.save
    
    armory["members"].each do |member|
      if member["character"]["level"] > 10 then
        character = Character.find_by_region_and_realm_and_name(region, realm, member["character"]["name"])
        character ||= Character.new
        
        character.region = region
        character.fetched_at = Time.now
        character.name = member["character"]["name"]
        character.realm = armory["realm"]
        character.race_id = member["character"]["race"]
        character.class_id = member["character"]["class"]
        character.gender_id = member["character"]["gender"]
        character.faction_id = faction_id(member["character"]["race"])
        character.level = member["character"]["level"]
        character.achievement_points = member["character"]["achievementPoints"]
        character.guild = guild
        
        character.save
      end
    end
  end
end
