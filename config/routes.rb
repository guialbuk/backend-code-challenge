Rails.application.routes.draw do
  post '/distance', to: 'distances#create', as: 'distance'
end
