class ProfilesController < ApplicationController
    before_action :set_profile, only: [
        :details, :edit, :update, :show, 
        :validate_profile, :rejected_profile, 
        :destroy, :active_edit, :unlock_account
    ]

    load_and_authorize_resource
    
    def index
        @pagy, @profiles_pending =     pagy(Profile.where(status: 0), items: 10)
        @pagy, @profiles_active =      pagy(Profile.where(status: 1), items: 10)
        @pagy, @profiles_rejecteds =   pagy(Profile.where(status: 3), items: 10)
    end

    def profiles_pending
        if params[:search]
            @pagy, @profiles_pending =     pagy(Profile.search(params[:search]).where(status: 0).order('created_at DESC'), items: 10)
        else
            @pagy, @profiles_pending =     pagy(Profile.where(status: 0).order('created_at DESC'), items: 10)
        end
    end

    def profiles_active
        if params[:search]
            @pagy, @profiles_active =     pagy(Profile.search(params[:search]).where(status: 1).order('created_at DESC'), items: 10)
        else
            @pagy, @profiles_active =     pagy(Profile.where(status: 1).order('created_at DESC'), items: 10)
        end
    end

    def profiles_rejecteds
        @pagy, @profiles_rejecteds =   pagy(Profile.where(status: 3), items: 10)
    end

    def profiles_blockeds
        @pagy, @profiles_blockeds =   pagy(Profile.profiles_blockeds, items: 10)
    end

    def details
        #redirect_to edit_profile_path(current_user.profile) #if current_user.profile_was_completed? if current_user.customer?
    end

    def adc_subscribed 
        profile = current_user.profile
        profile.update(profile_params_adc)
        redirect_to dashboard_path
    end

    def show
    end

    def edit
    end

    def reduce

        #@profile.reduce_parcels(current_user.id, params[:amount_to_discount].to_f, params[:is_credit])
        #redirect_to profile_path(@profile), notice: 'Plafom atualizado com sucesso.'
    end

    def validate_profile
        @profile.aprove
        redirect_to profile_path(@profile)
    end

    def active_edit
        @profile.active_editable
        redirect_to @profile, notice: 'Perfil habilitado para edição.'
    end

    def rejected_profile
        @profile.reject
        redirect_to profile_path(@profile)
    end

    def unlock_account
        @profile.user.unlock_account

        flash[:notice] = 'Instruções de desbloqueo de conta enviado com sucesso'
        redirect_to profile_path(@profile)
    end

    def update
        respond_to do |format|
            if @profile.update(profile_params)
                @profile.inactive_editable

                format.html { redirect_to current_user.customer? ? profiles_details_path(@profile) : profile_path(@profile), notice: 'Perfil atualizado com sucesso.' }
                format.json { render :show, status: :ok, location: @profile }
            else
                format.html { render :edit }
                format.json { render json: @profile.errors, status: :unprocessable_entity }
            end
        end
    end

    def destroy
        user = @profile.user

        if current_user.customer?
            if user.is_active?
                user.inactive_user
            else
                user.active_user
            end

            destroy_user_session_path
            redirect_to root_path, notice: 'conta eliminada com sucesso.'
        else
            #msg = "Caro cliente\nA sua conta Paga3 foi desactivada por não cumprir com os requisitos solicitados em nosso sistema, desde ja agradeços." 
            #SendSMS.new( msg, user.cell_phone ).wesender

            @profile.destroy
            user.destroy
            redirect_to profiles_pending_path, notice: 'Cliente eliminado com sucesso.'
        end
    end

    private
        def set_profile
            @profile = Profile.friendly.find(params[:id])
        end

        def profile_params_adc
            params.require(:profile).permit(
                :adc_subscribed
            )
        end

        def profile_params
            params.require(:profile).permit(
                :name, :bi, :salary, :position, :company_name, :address, :birth, :genre, :avatar,
                :have_credit, :amount_credit, :percentage_valid, :user_id, 
                :work_declaration, :banking_extrato, :can_edit, :iban, :amount_to_discount,
                :account_number, :employer_address, :operating_sector, :bank_id, :occupationArea_id,
                :adc_subscribed
            )
        end
end

