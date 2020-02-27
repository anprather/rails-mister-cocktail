Rails.application.routes.draw do
  get 'doses/index'
  get 'doses/new'
  get 'doses/create'
  get 'doses/update'
  get 'doses/edit'
  get 'cocktails/index'
  get 'cocktails/show'
  get 'cocktails/create'
  get 'cocktails/new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
