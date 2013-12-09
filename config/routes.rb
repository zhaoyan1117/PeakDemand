PeakDemand::Application.routes.draw do
  # root
  root :to => 'resource#index'
  
  # user
  devise_for :users, :skip => [:sessions, :registrations]
  as :user do
    post '/sign_in' => 'devise/sessions#create', :as => :user_session
    delete '/sign_out' => 'devise/sessions#destroy', :as => :destroy_user_session
    post '/sign_up' => 'registrations#create', :as => :user_registration
    put '/update_user' => 'registrations#update', :as => :update_user_registration
  end

  # mailing
  post '/mail/send' => 'UserMailer#send_email', :as => :mail_send

  # admin & announcement
  get 'admin/index' => 'Admin#index'
  post 'admin/enable_user' => 'Admin#enable_user'
  post 'admin/disable_user' => 'Admin#disable_user'
  resources :announcement, :except => [:index, :new, :edit]

  # resource & demand
  resources :resource do
    resources :demand, :except => :index
  end

end