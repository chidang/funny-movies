Rails.application.routes.draw do
  root to: 'pages#index'

  controller :sessions do
    post 'login' => :create
    get 'logout' => :destroy
  end

  resources :movies, only: [:new, :create, :edit, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
