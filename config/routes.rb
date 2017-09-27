Rails.application.routes.draw do
  root 'questions#index'
  devise_for :users
  
  concern :votable do 
    member do 
      post :vote_up
      post :vote_down
    end
  end
 
  resources :questions, concerns: [:votable] do 
    resources :answers do 
      patch :favorite, on: :member
    end
  end
  
  resources :answers, concerns: [:votable], only: [:vote_up, :vote_down]
  
  delete '/attachment/:id', to: 'attachments#destroy', as: :destroy_attachment
  
end