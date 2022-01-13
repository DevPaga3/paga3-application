class Profiles::BankAccountsController < BankAccountsController
    before_action :set_accountble

    def create
        # NOTIFY
        super
    end
    
    private
        def set_accountble
            @accountble = Profile.friendly.find(params[:profile_id])
        end
end
