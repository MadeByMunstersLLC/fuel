Fuel::Engine.routes.draw do

  scope module: 'fuel' do
    resources :posts
    get '/posts/:id' => 'posts#redirect'
    get '/' => 'posts#index', as: :blog_root

    namespace :admin do
      root to: 'posts#index'
      get "posts/preview" => 'posts#preview'
      get "posts/:slug/preview" => 'posts#preview'
      resources :posts do
        member do
          get 'content'
        end
      end
    end
  end

end