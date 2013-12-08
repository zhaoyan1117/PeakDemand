PeakDemand::Application.routes.draw do

  root :to => 'resource#index'

  devise_for :users
  post '/mail/send' => 'UserMailer#send_email'

  resources :announcement, :except => [:index, :new, :edit]

  resources :resource do
    resources :demand, :except => :index
  end

end
