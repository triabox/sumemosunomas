Rails.application.routes.draw do

  root 'static_pages#home'
  get 'help' => 'static_pages#help'
  get 'about' => 'static_pages#about'
  get 'contact' => 'static_pages#contact'

  #get 'prueba'  => 'becados_por_fundacions#index'
  #get 'prueba2'  => 'inscriptos#index'

  get 'password_resets/new'
  get 'password_resets/edit'
  get 'sessions/new'
  get 'users/new'

  get 'signup' => 'users#new'

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'


  get 'foundation' => 'users#foundation'
  get 'foundation_desactivar' => 'users#foundation_desactivar'
  get 'search' => 'users#search'
  get 'buscarCursos' => 'cursos#index'

  get 'inscribirBecado' => 'inscriptos#newBecado'
  get 'buscarRecursos' => 'recursos#index'


  resources :clases
  resources :recursos
  resources :cursos do
    resources :clases
    resources :recursos
  end

  resources :inscriptos
  resources :reputacion
  resources :becados_por_fundacions

  get 'foundation' => 'users#foundation'

  get 'listado_cursos' => 'cursos#index'
  get 'listado_recursos' => 'recursos#index'
  get 'crear_curso' => 'cursos#guide'
  get 'nuevo_curso' => 'cursos#new'
  get 'clases/:id' => 'clases#clases'

  get '/cursos/:id/publicar', to: 'cursos#publicar', as: 'publicar_curso'
  get '/cursos/:id/wantToFinish', to: 'cursos#wantToFinish', as: 'want_to_finish_curso'
  get '/cursos/:id/finish', to: 'cursos#finish', as: 'finish_curso'

  get '/users/:id/quieroApadrinar', to: 'users#quieroApadrinar', as: 'quiero_apadrinar_usuario'
  get '/users/:id/apadrinar', to: 'users#apadrinar', as: 'apadrinar_usuario'

  match 'gestionar/:id' => 'clases#gestionar', as: :gestionar_clase, :via => :get
  match 'gestionar/:id' => 'clases#tomar_asistencia', as: :tomar_asistencia, :via => :put

  resources :users
  resources :locations
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :messages
  resources :notifications, only: [:index]

  resources :payment, only: [:new, :create, :edit, :update]

  get '/inscriptos/:id/curso/:curso_id' => 'inscriptos#new', as: 'inscribir_a_curso'
  get '/cambia_pago_a_efectivo/:user_id/curso/:curso_id', to: 'inscriptos#cambia_pago_a_efectivo', as: 'cambia_pago_a_efectivo'
  get '/pago_efectivo/:user_id/curso/:curso_id', to: 'inscriptos#paga_en_efectivo', as: 'paga_en_efectivo'
  get '/pago_tarjeta/:user_id/curso/:curso_id', to: 'inscriptos#paga_con_tarjeta', as: 'paga_con_tarjeta'

  get '/mark_payment/:id/payment', to: 'payment#mark_payment', as: 'mark_payment'
  get '/mark_payment_todopago/:id/:status/payment', to: 'payment#mark_payment_todopago', as: 'mark_payment_todopago'
  get '/open_todopago/:id/payment', to: 'payment#open_todopago', as: 'open_todopago'

  resources :payment_types, only: [:new, :create, :edit, :update]

  #Messages Path
  #get 'send_messages/:id' => 'messages#new', as: :send_messages
  get 'messages_index' => 'messages#index', as: :messages_index
  get 'conversation/:id' => 'messages#conversation', as: :view_conversation
  get 'send_messages_recurso/:id' => 'messages#new_message_recurso', as: :send_messages_recurso

  #Fundaciones Path
  get 'fundaciones' => 'users#foundation', as: :fundaciones

  #Recursos Path
  get 'conseguido/:id' => 'recursos#conseguido', as: :conseguido

  match 'encuests/:id/edit' => 'encuests#edit', :as => :edit_encuest, :via => :get
  match 'encuests/:id/show' => 'encuests#show', :as => :show_encuest, :via => :get
  match 'encuests/:id' => 'encuests#completar', :as => :completar_encuesta, :via => :put

  #Reputacion Path
  get 'reputacion/:id' => 'reputacion#show', as: 'reputacion_user'

  #Notificaciones Path
  get 'notifications/:id' => 'notifications#ver', as: 'ver_notificacion'

  #Static Pages Path
  get 'quienes_somos' => 'about#quienes_somos', as: 'quienes_somos'
  get 'que_es' => 'about#que_es', as: 'que_es'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end