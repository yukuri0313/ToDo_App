Rails.application.routes.draw do
  #ユーザー関連
  get 'users/new' => "users#new"
  post "users/create" => "users#create"
  #ログイン／ログアウト
  get "login" => "users#login_form"
  post "users/login" => "users#login"
  get "logout" => "users#logout"
  #カテゴリー関連
  #get "categories/new" => "categories#new"
  post "categories/create" => "categories#create"
  get "categories/index" => "categories#index"
  #タスク関連
  get 'todoes/new' => "todoes#new"
  post 'todoes/create' => "todoes#create"
  get "todoes/:id/edit" => "todoes#edit"
  post "todoes/:id/update" => "todoes#update"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
