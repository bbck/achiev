class GuildJob
  @queue = :guild
  
  def self.perform(region, realm, name)
    guild = Guild.find_by_region_and_realm_and_name(region, realm, name)
    guild ||= Guild.new
    
    armory = Armory.guild_info(region, realm, name)
    
    # We need to set the region by hand
    guild.region      = region
    guild.realm       = armory.realm
    guild.name        = armory.name
    guild.faction_id  = armory.faction_id
    guild.fetched_at  = Time.now
    
    guild.save
    
    armory.characters.each do |character|
      Resque.enqueue(CharacterJob, "us", realm, character.name) unless character.level < 60
    end
    
    sleep 2
  end
end