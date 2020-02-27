Rails.application.routes.draw do
  resources :cocktails, only: [:index, :show, :new, :create, :destroy] do
    resources :doses, only: [:index, :new, :create]

  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
