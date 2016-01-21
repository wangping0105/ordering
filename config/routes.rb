Ordering::Application.routes.draw do
  devise_for :users
  resources :order_users do
    member do
      get :pay
    end
    collection do
      get :sign_out, :all_users
      post :notice
    end
  end

  resources :evaluations
  resources :orders do
    collection do
      post :talk
      get :show_talk_contents, :random_order
    end

  end

  resources :meals do
    collection do
      post :add_attachments
    end
  end

  resources :meal_types do
    collection do
      post :change_meal_type
    end
  end

  match '/open',to: 'orders#open', via: 'get'
  match '/destory',to:'orders#delete',via: 'get'
  match '/paying',to:'orders#paying',via: 'get'
  root to: "order_users#index"

end
