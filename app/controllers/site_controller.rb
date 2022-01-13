class SiteController < ActionController::Base
    layout 'site'
    before_action :set_comapny, only: [:available_products]

    
    def index
        @partners = Partner.where(status: true)
        redirect_to dashboard_path if user_signed_in?
        
    end
    
    def available_products
        @partners = Partner.where(status: true)
    end
    
    def empresas
        @partners = Partner.where(status: true)
        @companies = Company.where(show_in_site: true)
        @categories = Category.includes(:companies)
    end

    private
        def set_comapny
            @company = Company.friendly.find(params[:id])
        end
end
