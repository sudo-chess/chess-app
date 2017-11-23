Rails.application.routes.draw do
  
  devise_for :users
  
  root 'games#index'
  
  resources :games do 
    collection do
      get :pending
      get :playing
      get :complete
    end
  end

  resources :pieces 

end
