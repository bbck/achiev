class PagesController < ApplicationController
  
  def index
    @characters = Character.limit(10)
    @guilds = Guild.limit(10)
  end
end
