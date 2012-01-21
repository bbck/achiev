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

  def create
    respond_to do |format|
      format.js do
        unless params[:region].empty? or params[:realm].empty? or params[:name].empty? then
          Resque.enqueue CharacterJob, params[:region], params[:realm], params[:name]
          render 'create'
        else
          render 'create-fail'
        end
      end
    end
  end
end
