Rails.application.routes.draw do
  
  root to: 'top_pages#top'
  
  # SNSログイン
  get '/auth/:provider/callback' => 'user_sessions#create_sns_login'
  get "/auth/failure" => "user_sessions#failure"
  
  # パスワードリマインダー(User)
  get 'pass_reminder_user' => 'users#pass_reminder'
  post 'token_create_user' => 'users#token_create'
  get 'pass_token_user/:uuid', :to => 'users#pass_token'
  get 'reset_password_user' => 'users#reset_password'
  patch 'update_password_user' => 'users#update_password'

  # パスワードリマインダー(Developer)
  get 'pass_reminder_dev' => 'developers#pass_reminder'
  post 'token_create_dev' => 'developers#token_create'
  get 'pass_token_developer/:uuid', :to => 'developers#pass_token'
  get 'reset_password_dev' => 'developers#reset_password'
  patch 'update_password_dev' => 'developers#update_password'
  
  # ユーザー
  resources :users,only: [:new, :create, :destroy, :show, :edit, :update]
  resources :user_sessions, only: [:create, :destroy]
  
  # デヴェロッパー
  resources :developers,only: [:new, :create, :destroy, :show, :edit, :update]
  resources :dev_sessions, only: [:create, :destroy]
  
  # プロダクト
  resources :products,only: [:new, :create, :edit, :update, :show, :destroy]

  # ログイントークン(User)
  resources :users do
    get 'regist_token_user/:uuid', :to => 'users#regist_token'
  end
  # ログイントークン(Developer)
  resources :developers do
    get 'regist_token_dev/:uuid', :to => 'developers#regist_token'
  end
  
  #アプリ検索オーダー
  get 'top_pages/order_query', to: 'top_pages#result'
  post 'top_pages/order_query', to: 'top_pages#result'
  
  # ユーザーコメント
  resources :user_comments, only: [:show, :create]
  get 'top_pages/user_comment_all', to: 'top_pages#user_comment_all'
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
