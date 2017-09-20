Rails.application.routes.draw do
  root 'questions#index'
  devise_for :users
  
  resources :questions do
    resources :answers do
      patch :favorite, on: :member
    end
  end
  
  delete '/attachment/:id', to: 'attachments#destroy', as: :destroy_attachment
  
end