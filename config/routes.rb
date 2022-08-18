Rails.application.routes.draw do
  devise_for :users

  root to: redirect("/en/pages/home")

  scope "/:locale" do
    get "/pages/:id", to: "pages#show", as: :page

    resource :user, only: %i[show edit update destroy]
    resources :coupons
  end
end
