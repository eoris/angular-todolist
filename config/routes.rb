Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  root 'application#angular'

  resources :projects, only: [:index, :create, :update, :destroy], shallow: true do
    resources :tasks, only: [:create, :update, :destroy] do
      resources :comments, only: [:create, :destroy] do
        resources :attachments, only: [:create, :destroy]
      end
    end
  end

end
