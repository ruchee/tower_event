Rails.application.routes.draw do
  root 'events#index'

  get 'events', to: 'events#index'
  get 'events/index', to: 'events#index'
  get 'events/more', to: 'events#more'
end
