Rails.application.routes.draw do

  authenticate :user, lambda { |u| u.admin == true } do
    mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  end

  devise_for :users, controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
  }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources 'doom_meter', only: [:show, :new, :create] do
    resources 'doom', only: :create
  end
  post '/get_dooms', to: "doom_meter#get_dooms"
  post '/like', to: "doom#like"

  root to: 'doom_meter#show'
  get "*path" => redirect("/")
end
