Fuel::Engine.routes.draw do

  scope module: 'fuel' do

    root to: 'posts#index', as: :blog_root
    # admin namespace is listed first intentionally
    namespace :admin do
      root to: 'posts#index'
      post "posts/preview" => 'posts#preview'
      get "posts/:slug/posts/preview" => 'posts#preview'
      resources :posts, param: :slug do
        member do
          get 'content'
        end
      end
      resources :authors
      resources :categories, param: :slug
      resources :tags, param: :slug
    end

    resources :posts, only: [:index, :show]
    resources :categories, only: [:index, :show], param: :slug
    get '/:id' => 'posts#redirect'
  end

end