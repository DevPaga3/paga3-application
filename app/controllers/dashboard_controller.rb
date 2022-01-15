class DashboardController < ApplicationController
    before_action :set_publicity


    def index
        @publicities = Publicity.all.where(status: true)

        if current_user.admin?
            @companies = Company.all
            @profiles = Profile.all
        end

        if current_user.customer?
            @products = Product.all
            @invoices = Factura.all
            @stores = Store.all

            @profile = current_user.profile
        end
    end


    private
        def set_publicity
            @publicity = Publicity.all
        end

end