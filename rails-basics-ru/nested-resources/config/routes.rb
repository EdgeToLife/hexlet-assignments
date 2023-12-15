# frozen_string_literal: true

Rails.application.routes.draw do
  root 'homes#index'

  # BEGIN

  resources :posts do
    resources :comments, only: [:index, :new, :create], module: :posts
  end

  resources :comments, only: [:show, :edit, :update, :destroy], module: :posts

  # END
end
