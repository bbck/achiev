class GuildJob
  @queue = :guild
  
  def self.perform(region, realm, name)
    guild = Guild.find_by_region_and_realm_and_name(region, realm, name)
    guild ||= Guild.new
    
    armory = self.from_armory(region, realm, name)
    
    guild.region = region
    guild.fetched_at = Time.now
    guild.name = armory.name
    guild.realm = armory.realm
    guild.faction_id = armory.side
    guild.level = armory.level
    guild.achievement_points = armory.achievementPoints
    
    guild.save
    
    armory.members.each do |member|
      if member.character.level > 10 then
        Resque.enqueue(CharacterJob, region, realm, member.character.name)
      end
    end
    
    sleep 2
  end
  
  def self.from_armory(region, realm, name)
    WowCommunityApi::BattleNet.region = WowCommunityApi::Regions::const_get(region.upcase)
    WowCommunityApi::Guild.find_by_realm_and_name(realm, name, :members)
  end
end