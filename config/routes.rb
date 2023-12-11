Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :employees do
    member do
      get 'tax_deduction'
    end
  end
end
