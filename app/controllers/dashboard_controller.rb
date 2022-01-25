class DashboardController < ApplicationController
    before_action :set_publicity


    def index
        @publicities = Publicity.all.where(status: true)

        if current_user.admin?
            @companies = Company.all
            @profiles = Profile.all
        end

        if current_user.customer?
            @search_identity_text = "Por favor inserir o seu número de bilhete de identidade válido"

            #unless current_user.confirmation_cell_phone
            #    redirect_to confirmation_cell_phone_path
            #end

            @products = Product.all
            @invoices = Factura.all
            @stores = Store.all

            @profile = current_user.profile
        end
    end

    def search_identity_number

        if params[:search_identity_number].length > 10
            if Profile.validate_id_number(params[:search_identity_number])
                @search_identity_text = "Número valido"
            else
                @search_identity_text = "Número de bilhete inválido"
            end
        else
            @search_identity_text = "Por favor inserir o seu número de bilhete de identidade válido"
        end
    end


    private
        def set_publicity
            @publicity = Publicity.all
        end

end