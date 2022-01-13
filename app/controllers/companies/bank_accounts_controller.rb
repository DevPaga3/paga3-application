class Companies::BankAccountsController < BankAccountsController
    before_action :set_accountble

    def create
        # NOTIFY
        super
    end
    
    private
        def set_accountble
            @accountble = Company.friendly.find(params[:company_id])

        end
end
