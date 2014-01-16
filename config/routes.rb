PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  # get '/posts', to: 'posts#index'
  # get '/posts/:id', to: 'posts#show'
  # get '/posts/new', to: 'posts#new'
  # post '/posts', to: 'posts#create'
  # get '/posts/:id/edit', to: 'posts#edit'
  # patch '/posts/:id', to: 'posts#update'

    get '/posts/man', to: 'posts#man'


   resources :posts, except: [:destroy] do
    resources :comments, only: [:create]
   end


   resources :categories, only: [:new, :create, :show]

   get 'activate/:id', to: 'users#activate'

   get 'photos/poll', to: 'photos#poll'



    resources :users


   # users       GET    /users           users#index
   #             POST                    users#create
   # new_user    GET    /users/new       users#new
   # edit_user   GET    /users/:id/edit  users#edit
   # user        GET    /users/:id       users#show
   #             PATCH  /users/:id       users#update
   #             PUT    /users/:id       users#update
   #             DELETE /users/:id       users#destroy



















end
