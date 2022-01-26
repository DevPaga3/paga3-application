class UsersController < ApplicationController
    before_action :set_user, only: [
        :edit, 
        :update, 
        :destroy, 
        :show,
        :active_and_inactive_profile,
        :active_and_inactive_user, 
        :aprove_profile
    ]

    load_and_authorize_resource only: [:index]


    def index
        @pagy, @users = pagy(User.where(role: [222, 10, 12, 15, 20]), items: 10)
    end

    def active_and_inactive_profile
        if @user.is_active?
            @user.inactive_user
            redirect_to @user.profile, notice: 'Conta bloqueada com sucesso.'
        else
            @user.active_user
            redirect_to @user.profile, notice: 'Conta activada com sucesso.'
        end
    end


    def active_and_inactive_user
        if @user.is_active?
            @user.inactive_user
            redirect_to @user.company, notice: 'Conta bloqueada com sucesso.'
        else
            @user.active_user
            redirect_to @user.company, notice: 'Conta activada com sucesso.'
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
            @user = User.find(params[:id])
        end


end


