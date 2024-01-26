# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :web do
    root 'home#index'

    resources :movies do
      # BEGIN
      shallow do
        resources :comments, module: :movies, except: %i[edit update destroy]
        resources :reviews, module: :movies, except: %i[edit update destroy]
      end
      resources :comments, module: :movies, only: %i[edit update destroy]
      resources :reviews, module: :movies, only: %i[edit update destroy]
      # END
    end

    resources :reviews, only: %i[index]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
