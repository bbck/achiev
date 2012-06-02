class CharacterJob
  extend JobHelpers
  extend FailedHooks
  
  @queue = :character
  
  def self.perform(region, realm, name)
    character = Character.find_by_region_and_realm_and_name(region, realm, name)
    character ||= Character.new
    
    return unless character.fetched_at == nil || needs_update?(character.fetched_at)
    
    # Basic info
    armory = character_from_armory(region, realm, name)
    
    character.region = region
    character.fetched_at = Time.now
    character.name = armory["name"]
    character.realm = armory["realm"]
    character.race_id = armory["race"]
    character.class_id = armory["class"]
    character.gender_id = armory["gender"]
    character.faction_id = action_id(armory["race"])
    character.level = armory["level"]
    character.achievement_points = armory["achievementPoints"]
    
    # Guild
    unless armory["guild"].blank?
      guild = Guild.find_by_region_and_realm_and_name(region, realm, armory["guild"]["name"])
      guild ||= Guild.new
      if guild.id.nil?
        guild.region      = region
        guild.realm       = armory["realm"]
        guild.name        = armory["guild"]["name"]
        guild.faction_id  = faction_id(armory["race"])
        guild.level       = armory["guild"]["level"]
        guild.achievement_points = armory["guild"]["achievementPoints"]
        guild.fetched_at  = Time.at(0)
        guild.save
        
        Resque.enqueue(GuildJob, region, realm, armory["guild"]["name"])
      end
      character.guild = guild
    else
      character.guild = nil
    end
    
    character.save
  end
end
