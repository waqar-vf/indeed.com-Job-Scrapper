Rails.application.routes.draw do
  resources :companies
  resources :jobs
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "home#index"
  match "/home/crawl",  via: [ :post] , as: :crawl
  get	"/home/web-address/:company_name" => "home#web_address", as: :web_address
  match "/home/get-domains" ,via: [:get], as: :get_domains
  get "/home/get_company/:id" => "home#get_company", as: :get_company
  get "/home/get-emails/:id" => "home#get_emails", as: :get_emails
  get "/home/get-all-emails/:batch_id" => "home#get_all_emails", as: :get_all_emails
  get "/home/csv-download/:batch_id" => "home#csv_download", as: :csv_download
  get "/:batch_id"=> "home#index"
  post "/companies/import-csv" => "companies#import_csv", as: :import_csv

end
