Rails.application.routes.draw do

	devise_for :users
    get 'pages/home'
    root 'pages#home'

    resources :quickmods do
        resources :versions
        post 'versions/ajax_validate' => 'versions#ajax_validate'
    end
    post 'quickmods/ajax_validate' => 'quickmods#ajax_validate'
end
