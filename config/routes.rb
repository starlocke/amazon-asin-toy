Rails.application.routes.draw do

  # Products CRUD + "fetch_batch" action
  resources :products do
    collection do
      post 'fetch_batch'
    end
  end

  # The "main", "root", "/" page where our React app lives.
  get 'welcome/index'
  root :to => 'welcome#index'

end
