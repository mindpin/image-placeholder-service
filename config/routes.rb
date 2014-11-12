Rails.application.routes.draw do
  root 'home#index'

  get '/login' => 'home#login', as: :login
  post '/login' => 'home#do_login'
  get '/logout' => 'home#logout', as: :logout
end
