# frozen_string_literal: true

Rails.application.routes.draw do
  resources :customers, only: %i[new create show] do
    resources :phones, only: %i[new create]
    resources :payments, only: %i[new create update show] do
      get 'pending', on: :member, as: :pending
    end
  end

  root to: redirect('/customers/new')
end
