Rails.application.routes.draw do

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

end
