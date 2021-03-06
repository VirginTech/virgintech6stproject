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
  get 'regist_token_user/:uuid', :to => 'users#regist_token'
  # ログイントークン(Developer)
  get 'regist_token_dev/:uuid', :to => 'developers#regist_token'

  #アプリ検索オーダー
  get 'order_query', to: 'top_pages#result'
  post 'order_query', to: 'top_pages#result'
  
  # ユーザーコメント
  resources :user_comments, only: [:show, :create, :destroy]
  get 'user_comment_all', to: 'top_pages#user_comment_all'
  
  # コメントリプライ
  resources :comment_replies, only: [:show, :create, :destroy]

  # デヴェロッパーコメント
  resources :dev_comments, only: [:show, :create, :destroy, :edit, :update]
  get 'dev_comment_show', to: 'developers#dev_comment_show'
  get 'dev_comment_all', to: 'top_pages#dev_comment_all'
  
  # フォロー・フォロワー
  resources :user_follows, only: [:create, :destroy]
  # ユーザータイムライン
  get 'user_timeline', to: 'users#user_timeline'
  # お気に入りアプリ
  resources :favorites, only: [:create, :destroy]
  # お気に入りアプリ表示
  get 'user_favorite', to: 'users#user_favorite'
  # コメントブックマーク
  resources :bookmarks, only: [:create, :destroy]
  # ブックマークコメント表示
  get 'user_bookmark', to: 'users#user_bookmark'
  # アクティビティ表示
  get 'user_activity', to: 'users#user_activity'
  get 'dev_activity', to: 'developers#dev_activity'
  
  # フッターメニュー
  get 'about_site', to: 'docs#about_site'
  get 'terms', to: 'docs#terms'
  get 'privacypolicy', to: 'docs#privacypolicy'
  get 'contact', to: 'docs#contact'
  get 'faq', to: 'docs#faq'
  get 'developer_s', to: 'docs#developer_s'
  get 'advertising', to: 'docs#advertising'
  get 'notice', to: 'docs#notice'

  # お問い合わせ
  post 'contact_feedback', to: 'docs#contact_feedback'
  # 通知
  post 'notification', to: 'docs#notification'
  
  #===============
  #管理画面
  #===============
  #ログイン画面
  get 'admin_top/:uuid', to: "administrators#admin_top"
  resources :administrators, only: [:create, :destroy]
  #メニュー
  get 'admin_menu', to: "administrators#admin_menu"
  #おすすめアプリ
  get 'product_mail_info', to: "administrators#product_mail_info"
  post 'product_mail_info', to: "administrators#product_mail_info_send"
  #デベロッパーメール通知
  get 'dev_mail_info', to: "administrators#dev_mail_info"
  post 'dev_mail_info_send', to: "administrators#dev_mail_info_send"
  #ユーザーメール通知
  get 'user_mail_info', to: "administrators#user_mail_info"
  post 'user_mail_info_send', to: "administrators#user_mail_info_send"
  #お知らせ
  get 'admin_notice_new', to: "administrators#admin_notice_new"
  post 'admin_notice_save', to: "administrators#admin_notice_save"
  get 'admin_notice_edit', to: "administrators#admin_notice_edit"
  patch 'admin_notice_update', to: "administrators#admin_notice_update"
  #ユーザーログイン
  get 'admin_user_login', to: "administrators#admin_user_login"
  post 'admin_user_create', to: "administrators#admin_user_create"
  #デベロッパーログイン
  get 'admin_dev_login', to: "administrators#admin_dev_login"
  post 'admin_dev_create', to: "administrators#admin_dev_create"
  
  #エラーページ
  get '*path', to: 'errors#render_404'
  
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
