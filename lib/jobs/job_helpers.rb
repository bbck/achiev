module JobHelpers
  def character_from_armory(region, realm, name)
    Battlenet::API.set_option(:region, region.downcase.to_sym)
    Battlenet::API::Character.profile(name, realm, ["guild"])
  end
  
  def guild_from_armory(region, realm, name)
    Battlenet::API.set_option(:region, region.downcase.to_sym)
    Battlenet::API::Guild.profile(name, realm, ["members"])
  end
  
  def needs_update?(timestamp)
    timestamp < 3.days.ago
  end
end
