Rails.application.routes.draw do
  scope 'guests' do
    resources :authors, only: %i[index show] do
      resources :articles, only: %i[index show]
    end
  end
  scope 'writers' do
    resources :profiles, only: %i[index show edit update] do
      resources :posts
    end
  end
  scope 'managers' do
    resources :users do
      resources :blogs
    end
  end
  get '/landing', to: 'landing#index'
  root 'landing#index' # root path route ("/")
end
