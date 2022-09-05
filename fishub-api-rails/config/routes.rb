Rails.application.routes.draw do
  defaults format: :json do
    resources :baits, only: [:index] do
      resources :catches, only: [:index, :create]
    end

    resources :tackle_box_items, only: [:index, :create], 
              path: 'tackle-box-items'

    get 'activity', to: 'activity#index'

    resources :users, only: [:create]

    resource :session, only: [:create, :destroy]
  end
end
