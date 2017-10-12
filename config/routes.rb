Rails.application.routes.draw do
  resources :jobs
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "home#index"
  match "/home/crawl",  via: [ :post] , as: :crawl
end
