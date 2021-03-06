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
    end

    get '/posts'=> 'posts#index'
    resources :posts, only: [:index, :show], path: ''
    get '/posts/:id' => 'posts#redirect'

  end

end