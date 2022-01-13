# frozen_string_literal: true

class Ability
    include CanCan::Ability

    def initialize(user)

        user ||= User.new

        can :manage, :all if user.admin?

        #============= PERMISSION COMPANY ===============
        if user.company?
            can [:details, :update],    Company, id: user.company.id
            can [:manage], Store,       company: { id: user.company.id }
            can [:manage], Product,     company: { id: user.company.id }
            can [:manage], BankAccount
            can [:manage], Bank#,     company: { id: user.company.id }
        end

        #============ PERMISSION CUSTOMER ==============
        if user.customer?
            can [:manage], Profile,     user: { id: user.id }
            can [:my_requests, :cancel_my_request],    Request, id: user.profile.id
        end

        
        


    end
end
