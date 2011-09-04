Achiev::Application.routes.draw do

  match "/characters/:region/:realm/:name" => "characters#show", :as => :character
  match "/characters/:region/:realm" => "characters#index", :as => :characters_realm
  match "/characters/:region" => "characters#index", :as => :characters_region
  match "/characters" => "characters#index", :as => :characters_all
  
  match "/guilds/:region/:realm/:name" => "guilds#show", :as => :guild
  match "/guilds/:region/:realm" => "guilds#index", :as => :guilds_realm
  match "/guilds/:region" => "guilds#index", :as => :guilds_region
  match "/guilds" => "guilds#index", :as => :guilds_all

  root :to => "pages#index"
end
