Achiev::Application.routes.draw do

  match "/characters/:region/:realm/:name" => "characters#show", :as => :character
  match "/characters/:region/:realm" => "characters#index", :as => :characters_realm
  match "/characters/:region" => "characters#index", :as => :characters_region
  match "/characters" => "characters#index", :as => :characters_all

  root :to => "pages#index"
end
