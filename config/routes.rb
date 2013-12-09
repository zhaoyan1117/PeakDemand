PeakDemand::Application.routes.draw do

  # root
  root :to => 'resource#index'
  
  # user & mailing
  devise_for :users
  post '/mail/send' => 'UserMailer#send_email'

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
