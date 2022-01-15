Rails.application.routes.draw do
    resources :requests
    resources :moviments
    resources :messages


    get '/minhas-solicitacoes',                                       to: 'requests#my_requests',                 as: 'my_requests'
    get '/cancelar-solicitacao/:id',                                  to: 'requests#cancel_my_request',           as: 'cancel_my_request'
    put '/aprovar-solicitacao/:id',                                   to: 'requests#approve_request',             as: 'approve_request'
    put '/confirmacao-da-solicitacao/:id',                            to: 'requests#confirmation_request',        as: 'confirmation_request'

    


    root 'site#index'
    get '/empresas',                                                  to: 'site#empresas',                        as: 'empresas'
    get '/produtos_disponiveis/:id',                                  to: 'site#available_products',              as: 'available_products'
    
    #get '/termos-e-condicoes',                                        to: 'site#terms_and_conditios',             as: 'terms_and_conditios'
    
    devise_for :users, controllers: {
        sessions: 'users/sessions'
    }
    
    resources :users, only: [:index, :show, :new, :edit]
    get 'users/active_and_inactive_user/:id',                         to: 'users#active_and_inactive_user',       as: 'active_and_inactive_user'
    get 'users/active_and_inactive_profile/:id',                      to: 'users#active_and_inactive_profile',    as: 'active_and_inactive_profile'
    get 'users/aprove_profile/:id',                                   to: 'users#aprove_profile',                  as: 'aprove_profile'
    
    
    
    
    get '/pagamentos',                                                to: 'invoices#index',                       as: 'invoices'
    get '/vendas',                                                    to: 'invoices#sales',                       as: 'sales'
    get '/minhas_compras',                                            to: 'invoices#purchases',                   as: 'purchases'
    get '/recibo/:id',                                                to: 'invoices#recibo',                      as: 'recibo'
    get '/adc_details/:id',                                           to: 'invoices#adc_details',                 as: 'adc_details'
    
    
    
    get '/stores/:id/validate_cart/:pre_order_id',                    to: 'stores#validate_cart',                 as: 'validate_cart'
    post '/stores/:id/validate_code_and_finish/:pre_order_id',         to: 'stores#validate_code_and_finish',       as: 'validate_code_and_finish'
    get '/stores/:id/invoice_details/:factura_id',                    to: 'stores#invoice_details',               as: 'invoice_details'
    
    get '/detalhes_da_venda/:factura_id',                             to: 'invoices#details',                     as: 'details'
    get '/detalhes_da_compra/:factura_id',                            to: 'invoices#details_purchase',            as: 'details_purchase'
    get '/detalhes_da_factura/:factura_id',                           to: 'invoices#show',                        as: 'details_invoice'
    
    get '/stores/:id/remove_item_order/:item_order_id',               to: 'stores#remove_item_order',             as: 'remove_item_order'
    get '/stores/:id/consult_request',                                to: 'stores#consult_request',               as: 'consult_request'
    post '/stores/:id/add_product_to_list/:pre_order_id',             to: 'stores#add_product_to_list',           as: 'add_product_to_list'
    get '/stores/:id/details_of_current_order/:pre_order_id',         to: 'stores#details_of_current_order',      as: 'details_of_current_order'
    
    get '/dashboard',                                                 to: 'dashboard#index',                      as: 'dashboard'
    
    get 'profiles/validate_profile/:id',                                to: 'profiles#validate_profile',              as: 'validate_profile'
    get 'profiles/rejected_profile/:id',                                to: 'profiles#rejected_profile',              as: 'rejected_profile'
    get 'profiles/details/:id',                                        to: 'profiles#details',                      as: 'profiles_details'
    get 'profiles/active_edit/:id',                                    to: 'profiles#active_edit',                  as: 'active_edit'
    put 'profiles/:id',                                                to: 'profiles#reduce',                       as: 'reduce'
    post 'adc_subscribed',                                              to: 'profiles#adc_subscribed',               as: 'adc_subscribed'
    
    


    get 'clientes/pendentes',                                         to: 'profiles#profiles_pending',              as: 'profiles_pending'
    get 'clientes/activos',                                           to: 'profiles#profiles_active',               as: 'profiles_active'
    get 'clientes/rejeitados',                                        to: 'profiles#profiles_rejecteds',            as: 'profiles_rejecteds'
    
    
    get 'companies/details/:id',                                      to: 'companies#details',                    as: 'comapnies_details'
    get 'company/show_and_hidden_in_site/:id',                        to: 'companies#show_and_hidden_in_site',    as: 'show_and_hidden_in_site'
    get 'company/associate_user_company/:id',                         to: 'companies#associate_user_company',    as: 'associate_user_company'
    get 'company/reset-password/:id',                                 to: 'companies#reset_password_company_user',    as: 'reset_password_company_user'
    
    
    resources :admins                                                 #only: [:edit, :update]
    get 'admins/details/:id',                                         to: 'admins#details',                       as: 'admins_details'
    
    
    resources :publicities
    get 'publicity/show_pub_on_client/:id',                           to: 'publicities#show_pub_on_client',       as: 'show_pub_on_client'
    
    
    resources :partners
    get 'partner/show_and_hide_partner/:id',                          to: 'partners#show_and_hide_partner',       as: 'show_and_hide_partner'
    
    resources :categories
    resources :banks
    resources :products
    resources :stores
    resources :occupation_areas

    resources :companies do
        resources :bank_accounts, module: :companies
    end

    resources :configurations, only: [:edit, :update, :show] do
        resources :bank_accounts, module: :configurations
    end

    resources :profiles do
        resources :bank_accounts, module: :profiles
    end

end


