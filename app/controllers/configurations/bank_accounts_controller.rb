class Configurations::BankAccountsController < BankAccountsController
    before_action :set_accountble

    def create
        # NOTIFY
        super
    end
    
    private
        def set_accountble
            @accountble = current_user.config #Configuration.find(params[:configuration_id])
        end
end
