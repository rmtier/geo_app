Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "home#index"
  get 'find_points', to: 'home#search_points'
  get 'insert_node', to: 'home#insert_node'

end
