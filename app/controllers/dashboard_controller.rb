class DashboardController < ApplicationController
    before_action :set_publicity


    def index
        @publicities = Publicity.all.where(status: true)

        if current_user.admin?
            @companies = Company.all
            @profiles = Profile.all
        end

        if current_user.customer?
            @validate_cell_phone_number_text = "Por favor inserir o código de confirmação, enviado por SMS"
            @products = Product.all
            @invoices = Factura.all
            @stores = Store.all

            @profile = current_user.profile
        end
    end

    def validate_cell_phone_number
        if params[:sms_code].length == 4
            if ValidationCode.validation(current_user, params[:sms_code])
                current_user.update_confirmation_cell_phone
                redirect_to root_path, notice: 'Conta validada com sucesso.'
            else
                @validate_cell_phone_number_text = "Código inválido"
            end
        else
            @validate_cell_phone_number_text = "Código inválido"
        end
    end


    private
        def set_publicity
            @publicity = Publicity.all
        end

end