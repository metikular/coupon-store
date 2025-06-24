Rails.application.routes.draw do
  devise_for :users

  root to: redirect("/en/pages/home")

  scope "/:locale" do
    get "/pages/:id", to: "pages#show", as: :page

    resource :user, only: %i[show edit update destroy] do
      resource :expiration_notification, only: %i[edit update], module: :users
    end
    resources :coupons do
      resource :badge, only: :destroy, module: :coupons
    end
    resources :loyalty_cards do
      resource :badge, only: :destroy, module: :loyalty_cards
    end
    resources :gift_cards do
      resources :charges, except: :show
      resource :balance, only: %i[edit update]
      resource :badge, only: :destroy, module: :gift_cards
    end
    resource :search, only: :show
    resource :barcodes, only: :show
  end
end
