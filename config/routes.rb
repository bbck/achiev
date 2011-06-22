Achiev::Application.routes.draw do

  match "/characters/:region/:realm/:name" => "characters#show"
  match "/characters/:region/:realm" => "characters#index"
  match "/characters/:region" => "characters#index"
  match "/characters" => "characters#index"

  root :to => "pages#index"
end
