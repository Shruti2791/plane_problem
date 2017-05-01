Rails.application.routes.draw do
  root 'home#index'
  resources :planes, only: [:new, :create, :edit, :update, :index, :show] do
    post :book_tickets
  end
end
