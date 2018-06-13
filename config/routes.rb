Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'github_details#home'
  get 'github_details/repositories'
  get 'auth/github', as: 'github_auth'
  match 'auth/:provider/callback' => 'session#create', via: [:get, :post] 
  get 'session/create'
  get 'session/destroy', as: 'logout'
end
