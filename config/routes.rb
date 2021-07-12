Rails.application.routes.draw do

  # mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {registrations: :registrations}

  devise_scope :user do
    get '/users', to: 'devise/registrations#new'
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :blogs do
    resources :likes
  end

  get 'index', to: 'pages#index', as:'index'

  get 'user_profile', to: 'pages#user_profile', as:'user_profile'

  get 'myblogs', to: 'blogs#my_blog', as:'myblogs'

  root to: redirect('index', status: 302)


  get 'comments/create'
  
  resources :blogs do
    resources :comments, module: :blogs
  end




  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
