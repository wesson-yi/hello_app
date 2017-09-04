Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
  get 'hello',    to: 'application#hello'
  get 'goodbye',  to: 'application#goodbye'

  get '/home',        to: 'static_pages#home'
  get '/about',       to: 'static_pages#about'
  get '/contact',     to: 'static_pages#contact'
  get '/help',        to: 'static_pages#help'
  get '/faq',         to: 'static_pages#faq'
  get '/position',    to: 'static_pages#position'
  get '/flex_layout', to: 'static_pages#flex_layout'

  mount Api::V1::Haha => '/api'
end
