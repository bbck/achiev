class GuildsController < ApplicationController
  def index
    case
    when params[:region] && params[:realm]
      @guilds = Guild.rank.where(:region => params[:region]).where(:realm => params[:realm]).page params[:page]
    when params[:region]
      @guilds = Guild.rank.where(:region => params[:region]).page params[:page]
    else
      @guilds = Guild.rank.page params[:page]
    end
  end
  
  def show
    @guild = Guild.find_by_region_and_realm_and_name(params[:region], params[:realm], params[:name])
    @members = @guild.characters.rank.page params[:page]
  end
  
end
