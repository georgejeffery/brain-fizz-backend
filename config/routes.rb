Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

   namespace :api do
    namespace :v1 do      
      resources :users
      resources :notes
      resources :tags
      post 'authenticate', to: 'authentication#create'
      get 'usernotes', to: 'notes#get_user_notes'
      get 'monthtone', to: 'users#get_month_tone'
    end
  end
end
