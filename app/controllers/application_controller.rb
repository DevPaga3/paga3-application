class ApplicationController < ActionController::Base
    include Pagy::Backend

    
    before_action :authenticate_user!
    protect_from_forgery with: :exception
    before_action :configure_permitted_parameters, if: :devise_controller?

    rescue_from CanCan::AccessDenied do |exception|
        respond_to do |format|
            format.json { head :forbidden, content_type: 'text/html' }
            format.html { redirect_to main_app.root_url, alert: 'Lamentamos, não tens permissão para executar esta acção' }
            format.js   { head :forbidden, content_type: 'text/html' }
        end
    end
    
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit( 
            :identity_number, 
            :email, 
            :cell_phone, 
            :confirmation_terms, 
            :password, 
            :password_confirmation
        ) }
        devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit( :login, :email, :cell_phone, :password ) }
        devise_parameter_sanitizer.permit(:account_update) { |u| u.permit( :cell_phone ) }
    end

end
