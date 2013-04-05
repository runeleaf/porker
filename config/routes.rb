Porker::Application.routes.draw do
  resources :plans do
    resources :cards do
      collection { get :events }
    end
  end
end
