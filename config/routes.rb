Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', :controllers => { :omniauth_callbacks => "callbacks" }

  root 'application#angular'

  shallow do
    resources :projects, only: [:index, :create, :update, :destroy] do
      resources :tasks, only: [:create, :update, :destroy]
    end

    resources :tasks, only: [] do
      resources :comments, only: [:create, :destroy]
    end

    resources :comments, only: [] do
      resources :attachments, only: [:create, :destroy]
    end
  end

  # resources :projects, only: [:index, :create, :update, :destroy], shallow: true do
  #   resources :tasks, only: [:create, :update, :destroy] do
  #     resources :comments, only: [:create, :destroy] do
  #       resources :attachments, only: [:create, :destroy]
  #     end
  #   end
  # end

end
