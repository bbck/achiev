class CharactersController < ApplicationController
  def index
    case
    when params[:region] && params[:realm]
      @characters = Character.where(:region => params[:region]).where(:realm => params[:realm])
    when params[:region]
      @characters = Character.where(:region => params[:region])
    else
      @characters = Character.all
    end
  end
  
  def show
  end

end
