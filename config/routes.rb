Rails.application.routes.draw do
  devise_for :users
  root 'tasks#index'
  resources :tasks, only: [:index, :create, :destroy, :update] do
    resources :task_details, only: [:index, :create, :destroy, :update],
    shallow: true
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
