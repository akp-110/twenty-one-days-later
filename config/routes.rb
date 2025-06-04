Rails.application.routes.draw do
  get "comments/create"
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"

 resources :groups, only: [:index, :new, :create, :show, :destroy] do
  resources :group_memberships, only: [:create]
  resources :goals, only: [:new, :create, :index, :show, :edit, :update, :destroy]
  resources :comments, only: [:create]

  # goal_completions with only update_progress on collection
  resources :goal_completions, only: [] do
    post :update_progress, on: :collection
  end
end

end
