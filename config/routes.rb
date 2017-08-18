Rails.application.routes.draw do

  mount_devise_token_auth_for 'User', at: 'auth'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :projects, except: :show do
        resources :tasks, except: :show do
          resources :comments, only: [:index, :create, :destroy]
        end
        put 'sort_tasks', to: 'tasks#sort'
      end
    end
  end

  apipie
end
