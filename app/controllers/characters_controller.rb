class CharactersController < ApplicationController
  def index
    case
    when params[:region] && params[:realm]
      @characters = Character.rank.includes(:guild).where(:region => params[:region]).where(:realm => params[:realm]).page params[:page]
    when params[:region]
      @characters = Character.rank.includes(:guild).where(:region => params[:region]).page params[:page]
    else
      @characters = Character.rank.includes(:guild).page params[:page]
    end
  end
  
  def show
    @character = Character.find_by_region_and_realm_and_name(params[:region], params[:realm], params[:name])    
  end
end
