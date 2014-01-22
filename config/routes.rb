PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  # get '/posts', to: 'posts#index'
  # get '/posts/:id', to: 'posts#show'
  # get '/posts/new', to: 'posts#new'
  # post '/posts', to: 'posts#create'
  # get '/posts/:id/edit', to: 'posts#edit'
  # patch '/posts/:id', to: 'posts#update'

  # POST /votes => 'VotesContorller#create'
  # - needs two pieces of information

  # Post /posts/:post_id/vote - to vote action
  # POST /comments/4/vote => 'Comments '

  # resources :votes, only: [:create, :update]

  get '/register', to: 'users#new', as: 'register'
    #creates register_path automatically

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  #POST /posts/3/vote
  resources :posts, except: [:destroy] do
    member do
      post :vote
    end

    resources :comments, only: [:create] do
      member do
        post :vote
      end
    end
  end


  resources :categories, only: [:new, :create, :show]

  get '/activate/:id', to: 'users#activate'

  get '/photos/poll', to: 'photos#poll'



  resources :users, except: [:new]


  # users       GET    /users           users#index
  #             POST                    users#create
  # new_user    GET    /users/new       users#new
  # edit_user   GET    /users/:id/edit  users#edit
  # user        GET    /users/:id       users#show
  #             PATCH  /users/:id       users#update
  #             PUT    /users/:id       users#update
  #             DELETE /users/:id       users#destroy



















end
