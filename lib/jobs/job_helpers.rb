module JobHelpers
  def character_from_armory(region, realm, name)
    armory = Battlenet.new(region.downcase.to_sym)
    armory.character(realm, name, :fields => "guild")
  end
  
  def guild_from_armory(region, realm, name)
    armory = Battlenet.new(region.downcase.to_sym)
    armory.guild(realm, name, :fields => "members")
  end
  
  def needs_update?(timestamp)
    timestamp < 3.days.ago
  end
end
