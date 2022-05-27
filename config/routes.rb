Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'pages#home'
  post 'generate_meme', to: 'pages#generate_meme'
  get 'form', to: 'pages#form'
end
