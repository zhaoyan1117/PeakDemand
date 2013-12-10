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
  post '/mail/consumer' => 'UserMailer#send_email_consumer', :as => :mail_consumer
  post '/mail/provider' => 'UserMailer#send_email_provider', :as => :mail_provider

  # admin & announcement
  get 'admin/index' => 'admin#index'
  get 'admin/enable_user/:user_id' => 'admin#enable_user', :as => 'admin_enable'
  resources :announcement, :except => [:index, :new, :edit]

  # resource & demand
  resources :resource, :except => [:new, :edit] do
    resources :demand, :except => [:index, :new, :edit] do
      member do
        get :get_demand_from_gcal_id, :as => 'gcal_id_to_demand'
      end
    end
  end

end