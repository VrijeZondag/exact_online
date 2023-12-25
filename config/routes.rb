Rails.application.routes.draw do
  namespace :exact_online do
    resource :authentication, only: %w[new] do
      get :webhook, on: :collection
    end

    resources :customers, only: [] do
      post :webhook, on: :collection
    end

    resources :purchase_invoices, only: [] do
      post :webhook, on: :collection
    end
  end
end
