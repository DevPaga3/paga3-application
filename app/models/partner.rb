class Partner < ApplicationRecord
    has_one_attached    :avatar
    

    def show_and_hide_partner
        if self.status
            self.update_columns(status: false)
        else
            self.update_columns(status: true)
        end
    end
end
