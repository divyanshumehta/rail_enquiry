Rails.application.routes.draw do
  get 'enquiry/index'
  root 'enquiry#index'

  post 'enquiry/query' => 'enquiry#query', as: 'query'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
