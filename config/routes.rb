Rails.application.routes.draw do
  devise_for :users
  resources :users , :readings 

  # You can have the root of your site routed with "root"
  root 'home#index'
    resources :reports  , only: [:index] do
      collection do
        get 'daily', controller: 'reports', as: :daily_report
        post 'daily', controller: 'reports', as: :post_daily_report
        get 'monthly', controller: 'reports', as: :monthly_report
        post 'monthly', controller: 'reports', as: :post_monthly_report
        get 'date_wise', controller: 'reports', as: :date_wise_report
        post 'date_wise', controller: 'reports', as: :post_date_wise_report
      end
    end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
