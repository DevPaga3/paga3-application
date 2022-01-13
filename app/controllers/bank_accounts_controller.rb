class BankAccountsController < ApplicationController
    load_and_authorize_resource
    
    def new
        @bank_account = @accountble.bank_accounts.new
    end

    def create
        @bank_account = @accountble.bank_accounts.new(bank_account_params)
        @accountble.save

        if current_user.customer?
            redirect_to profiles_details_path(current_user.profile), notice: "Conta bancária adicionada com sucesso"
        end

        if current_user.company?
            redirect_to comapnies_details_path(current_user.company), notice: "Conta bancária adicionada com sucesso"
        end

        if current_user.admin?
            redirect_to configuration_path(current_user.config), notice: "Conta bancária adicionada com sucesso"
        end
    end

    private
        def bank_account_params
            params.require(:bank_account).permit(:bank_id, :iban, :account_number)
        end

end
