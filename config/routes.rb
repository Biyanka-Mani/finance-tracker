Rails.application.routes.draw do
 
  resources :user_stocks,only:[:create,:destroy]
  resources :friendships,only:[:create,:destroy]
  
  
  devise_for :users
  resources :users,only:[:show]
  root 'welcome#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get 'my_portfolio',to:'users#my_portfolio'
  get 'search_stock',to:'stocks#quote',as: 'search_stock'

  get 'my_friends',to:'users#my_friends'
  get 'search_friend',to:'users#search',as: 'search_friend'


  get 'Stocks',to:'stocks#stock_symbols'
 

  get 'search',to:'stocks#symbol_search'
   get '_search/:ticker_symbol',to:'stocks#search'

 get 'similarity',to:'stocks#similarity_index'
  # Defines the root path route ("/")
  # root "posts#index"
end
