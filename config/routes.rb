Rails.application.routes.draw do
  devise_for :users

  get 'search/index', to: 'search#index', as: :home
  get 'search/show/:id', to: 'document#show'

  get 'document', to: 'document#index'
  post 'document/create', to: 'document#create'
  get 'moderate/edit/:id', to: 'document#edit'
  post 'moderate/edit/:id', to: 'document#update'

  get 'moderate', to: 'moderate#index'
  delete 'moderate', to: 'document#delete'
  post 'moderate/approve', to: 'document#approve'
  get 'moderate/show_approved', to: 'moderate#show_approved'

  root 'search#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
