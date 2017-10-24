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
      resources :faqs
      resources :faq_categories, param: :slug
      resources :categories, param: :slug
      resources :tags, param: :slug
    end

    resources :posts, only: [:index, :show]
    resources :categories, only: [:index, :show], param: :slug
    resources :faq_categories, only: [:index, :show], param: :slug
    resources :faqs, only: [:index, :show]
    get '/:id' => 'posts#redirect'
  end

end