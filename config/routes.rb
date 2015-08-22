Rails.application.routes.draw do

  get '/auth/:provider/callback' => 'sessions#create'
  get '/login' => 'sessions#new', :as => :login
  get '/logout' => 'sessions#destroy', :as => :logout
  get '/auth/failure' => 'sessions#failure'

  resources :user, param: :name, :only => "show" do
    collection do
      get 'following' => "user#following", concerns: :schedulable
      get "likes" => "user#likes"
    end
  end

  resources :blog, param: :blog_name, :path => "", :only => "show" do
    member do
      get 'posts' => "blog#posts"
      get "posts/destroy" => "posts#destroy"

      get 'drafts' => "blog#drafts"
      get 'drafts/publish/:quantity/every/:n/:unit(/:pick)' => "drafts#publish"
      delete 'drafts/destroy/:quantity' => "drafts#destroy"

      get 'queue' => "blog#queue"
      get 'queue/refill/:quantity(/:sort)' => "queue#refill"
      delete 'queue/destroy/:quantity' => "queue#destroy"

      get 'followers(/:follow/:active)' => "blog#followers"
      get 'likes(/:unlike)' => "blog#followers"
    end
  end

  get 'drafts/publish/:blog_name' => "drafts#publish"
  get 'queue/refill/:blog_name' => "queue#refill"
  get 'posts/delete/:blog_name' => "posts#delete"

  namespace :viewer do
    scope :blog do
      get '(/:name)' => "blog#index"
      get ':name/info' => "blog#info"
      get ':name/avatar' => "blog#avatar"
      get ':name/followers' => "blog#followers"
      get ':name/likes' => "blog#likes"
      get ':name/posts(/:type)' => "blog#posts"
      get ':name/queue' => "blog#queue"
      get ':name/draft' => "blog#draft"
      get ':name/submissions' => "blog#submissions"
    end
    scope :user do
      get '/' => "user#index"
      get 'info' => "user#info"
      get 'dashboard' => "user#dashboard"
      get 'likes' => "user#likes"
      get 'following' => "user#following"
      get 'follow' => "user#follow"
      get 'unfollow' => "user#unfollow"
      get 'like' => "user#like"
      get 'unlike' => "user#unlike"
    end
  end

  root to: 'high_voltage/pages#show', id: 'features'

end
