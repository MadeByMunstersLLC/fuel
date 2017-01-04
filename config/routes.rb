Fuel::Engine.routes.draw do

  scope module: 'fuel' do

    root to: 'posts#index', as: :blog_root
    # admin namespace is listed first intentionally
    namespace :admin do
      root to: 'posts#index'
      post "posts/preview" => 'posts#preview'
      get "posts/:slug/posts/preview" => 'posts#preview'
      resources :posts do
        member do
          get 'content'
        end
      end
      resources :authors
      resources :categories, param: :slug
      resources :tags, param: :slug
    end

    get '/posts' => 'posts#index'
    resources :posts, only: [:index, :show]
    get '/posts/:id' => 'posts#redirect'
    resources :categories, only: [:index]
  end

end