# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users,
             controllers: { registrations: 'users/registrations' },
             path: 'auth',
             path_names: {
               sign_in: 'login',
               sign_out: 'logout',
               password: 'secret',
               confirmation: 'verification',
               unlock: 'unblock',
               registration: 'register',
               sign_up: 'signup'
             }

  scope 'admin' do
    resources :users do
      collection do
        match :profile, via: %i[get post]
      end
      member do
        put :disable
      end
    end
    resources :roles
    resources :projects
    resources :reports
    resources :sales
    resources :repertories
    resources :purchases
    resources :companies
    resources :storages
    resources :deliveries
    resources :suppliers
    resources :distributors
    resources :finances
    resources :settings
    resources :brands
    resources :products
    resources :product_units, path: 'productunits'
    resources :permissions
    resources :reimbursements do
      collection do
        get :all
      end
      member do
        put :confirm
        put :pay
      end
    end
  end

  root 'home#index'
end
