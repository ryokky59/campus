Rails.application.routes.draw do

  get 'sessions/new'

  root to: 'pictures#index'

  resources :pictures do
    collection do
      post :confirm
    end
  end

  resources :users, only: [:new, :create, :show, :destroy] do
    collection do
      get :favorite
    end
  end

  resources :sessions, only: [:new, :create, :destroy]

  resources :favorites, only: [:create, :destroy]

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

end
