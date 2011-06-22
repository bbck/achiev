class CharactersController < ApplicationController
  def index
    case
    when params[:region] && params[:realm]
      @characters = Character.where(:region => params[:region]).where(:realm => params[:realm]).page params[:page]
    when params[:region]
      @characters = Character.where(:region => params[:region]).page params[:page]
    else
      @characters = Character.all.page params[:page]
    end
  end
  
  def show
  end

end
