Rails.application.routes.draw do
  devise_for :users
  resource :dashboard, only: [:show]
  root 'games#index'
  get 'team', to: 'static_pages#team'
  resources :games do
    collection do
      get :pending
      get :playing
      get :complete
    end
    member do
      post :forfeit
      post :castle_king_side
      post :castle_queen_side
    end

  end
  resources :pieces
end
