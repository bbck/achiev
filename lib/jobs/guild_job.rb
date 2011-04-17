class GuildJob
  @queue = :guild
  
  def self.perform(region, realm, name)
    Armory.guild_info(region, realm, name).characters.each do |character|
      Resque.enqueue(CharacterJob, "us", realm, character.name) unless character.level < 10
    end
    sleep 2
  end
end