Rails.application.routes.draw do
  devise_for :users

  root to: redirect("/en/pages/home")

  scope "/:locale" do
    get "/pages/:id", to: "pages#show", as: :page

    resource :user, only: %i[show edit update destroy] do
      resource :expiration_notification, only: %i[edit update], module: :users
    end
    resources :coupons
    resources :loyalty_cards
    resources :gift_cards do
      resources :charges, except: :show
      resource :balance, only: %i[edit update]
    end
    resource :search, only: :show
  end
end
