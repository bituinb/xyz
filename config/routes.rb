Rails.application.routes.draw do
  resources :accounts
  root to: 'accounts#index'
  mount ResqueWeb::Engine => 'admin/resque_web'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
