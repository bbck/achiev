class GuildsController < ApplicationController
  def index
    case
    when params[:region] && params[:realm]
      @guilds = Guild.where(:region => params[:region]).where(:realm => params[:realm]).page params[:page]
    when params[:region]
      @guilds = Guild.where(:region => params[:region]).page params[:page]
    else
      @guilds = Guild.page params[:page]
    end
  end
  
  def show
    @guild = Guild.find_by_region_and_realm_and_name(params[:region], params[:realm], params[:name])
    @members = @guild.characters.page params[:page]
  end
  
end
