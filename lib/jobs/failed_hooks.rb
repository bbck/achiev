module FailedHooks
  def on_failure(e, *args)
    if e.code == 503
      Resque.enqueue self, *args
      puts "API limit reached. Will retry in 30 minutes..."
      sleep 1800
    elsif e.code == 500
      Resque.enqueue self, *args
      puts "Blizzard API error. Will retry in 5 minutes..."
      sleep 500
    elsif e.code == 404
      if self.name == "CharacterJob"
        character = Character.find_by_region_and_realm_and_name(*args)
        character.destroy unless character.nil?
      elsif self.name == "GuildJob"
        guild = Guild.find_by_region_and_realm_and_name(*args)
        guild.destroy unless guild.nil?
      end
    end
  end
end
