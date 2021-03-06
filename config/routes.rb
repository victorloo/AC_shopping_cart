Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :products, only: [:index, :show] do
    # 自製的連結，因為不符合 RESTful 的七個名稱，所以要標注動詞(post)、使用的路徑名稱、對象是單一(member)還是全部
    post :add_to_cart, on: :member
    post :remove_from_cart, on: :member
    post :adjust_item, on: :member
  end
  root 'products#index'

  resource :cart
  # 因為 cart 上的商品加減都會用到，所以全開

  resources :orders do
    post :checkout_spgateway, on: :member
    # post :spgateway_return, on: :collection
    # 打算繞過 orders，改採下方寫法
  end

  post "spgateway/return" #因此需要專屬的 controller
  post "spgateway/notify"

  namespace :admin do
    resources :products
    resources :users
    resources :orders
    root 'products#index'
  end
end