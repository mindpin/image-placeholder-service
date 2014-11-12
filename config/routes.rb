Rails.application.routes.draw do
  resources :images

  root 'home#index'

  get '/login' => 'home#login', as: :login
  post '/login' => 'home#do_login'
  get '/logout' => 'home#logout', as: :logout
  get '/:width/:height' => 'images#fill_image', as: :fill_image
end
