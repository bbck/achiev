module JobHelpers
  def character_from_armory(region, realm, name)
    armory = Battlenet.new(region.downcase.to_sym, APP_CONFIG["bnet_public"], APP_CONFIG["bnet_private"])
    armory.character(realm, name, :fields => "guild")
  end
  
  def guild_from_armory(region, realm, name)
    armory = Battlenet.new(region.downcase.to_sym, APP_CONFIG["bnet_public"], APP_CONFIG["bnet_private"])
    armory.guild(realm, name, :fields => "members")
  end
  
  def needs_update?(timestamp)
    timestamp < 3.days.ago
  end
  
  def faction_id(race)
    [1,3,4,7,11,22].include?(race) ? 0 : 1
  end
end
