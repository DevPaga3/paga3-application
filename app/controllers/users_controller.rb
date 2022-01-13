class UsersController < ApplicationController
    before_action :set_user, only: [:edit, :update, :destroy, :show, :active_and_inactive_user, :aprove_profile]


    def index
        @pagy, @users = pagy(User.where(role: [222, 10, 12, 15, 20]), items: 10)
    end


    def active_and_inactive_user
        if @user.is_active?
            @user.inactive_user
            redirect_to @user.company, notice: 'conta empresa desactivada com sucesso.'
        else
            @user.active_user
            redirect_to @user.company, notice: 'conta empresa activada com sucesso.'
        end
    end

    def aprove_profile
        @user.aprove_profile
        redirect_to @user.profile, notice: 'Conta aprovada com sucesso.'
    end

    def show

    end

    
    def edit
        
    end





    private
        def set_user
            @user = User.friendly.find(params[:id])
        end


end


