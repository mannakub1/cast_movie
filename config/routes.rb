Rails.application.routes.draw do
  mount V1::API => '/'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
