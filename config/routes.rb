Ordering::Application.routes.draw do
  get 'meals/index'

  devise_for :users
  resources :order_users do
    member do
      get :pay
    end
  end

  resources :orders do

  end

  resources :meals do

  end
  match '/open',to: 'orders#open', via: 'get'
  match '/destory',to:'orders#delete',via: 'get'
  match '/paying',to:'orders#paying',via: 'get'
  root to: "order_users#index"

end
