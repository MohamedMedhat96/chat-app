# frozen_string_literal: true

Rails.application.routes.draw do
  get 'applications/:token' => 'applications#show'
  put 'applications/:token' => 'applications#update'
  post 'applications/:token' => 'applications#update'
  delete 'applications/:token' => 'applications#destroy'

  get 'chats/:number' => 'chats#show'
  put 'chats/:number' => 'chats#update'
  post 'chats/:number' => 'chats#update'
  delete 'chats/:number' => 'chats#destroy'

  get 'messages/search' => 'messages#search'
  get 'messages/:number' => 'messages#show'
  put 'messages/:number' => 'messages#update'
  post 'messages/:number' => 'messages#update'
  delete 'messages/:number' => 'messages#destroy'

  resources :messages, except: %i[destroy show update search]
  resources :chats, except: %i[destroy show update]
  resources :applications, except: %i[destroy show update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
