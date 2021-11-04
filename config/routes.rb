Rails.application.routes.draw do
  devise_for :users
  root 'homes#top'
  get 'home/about' => 'homes#about'
  
  resources :users,only: [:show,:index,:edit,:update, :follower, :followed] do
    resource :relationships, only: [:create, :destroy, :show]
    get :follower, on: :member
    get :followed, on: :member
  end
  
  resources :books do
  resource :favorites, only: [:create, :destroy]
  resources :book_comments, only: [:create, :destroy]
  
  end
  
end