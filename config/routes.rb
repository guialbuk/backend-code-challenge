Rails.application.routes.draw do
  root to: proc { [404, {}, ['404 (Not Found)']] }

  post '/distance', to: 'distances#create', as: 'distance'
  get '/cost', to: 'costs#show', as: 'cost'
end
