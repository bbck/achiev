Achiev::Application.routes.draw do
  resources :characters, :except => [:show]
  get "/characters(/:region(/:realm))" => "characters#index", :as => :characters
  get "/characters/:region/:realm/:name" => "characters#show", :as => :character
  
  resources :guilds, :except => [:show]
  get "/guilds(/:region(/:realm))" => "guilds#index", :as => :guilds
  get "/guilds/:region/:realm/:name" => "guilds#show", :as => :guild

  root :to => "pages#index"
end
