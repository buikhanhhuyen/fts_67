Rails.application.routes.draw do
  root "static_pages#home"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :exams, except: [:edit, :destroy]
  resources :suggest_questions, except: [:index, :destroy]
  resources :users
  namespace :admin do
    root "static_pages#home"
    resources :users, only: [:index, :destroy, :show]
    resources :subjects
    resources :questions
    resources :suggest_questions, except: [:create, :edit]
  end
end
