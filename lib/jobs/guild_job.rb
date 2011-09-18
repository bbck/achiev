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
    
    armory["members"].each do |member|
      if member["character"]["level"] > 10 then
        Resque.enqueue(CharacterJob, region, realm, member["character"]["name"]) 
      end
    end
    
    guild.save
  end
end
