class AdminsController < ApplicationController
    before_action :set_admin, only: [:details, :edit, :update, :show, :destroy]
    load_and_authorize_resource
    
    def index
        @pagy, @admins = pagy(Admin.all, items: 10)
    end
    
    def edit
    end

    def show
        
    end

    def new
        @admin = Admin.new
    end

    def create
        @admin = Admin.new(admin_params)

        respond_to do |format|
            if @admin.save
            
                pw = rand(2**256).to_s(36).ljust(8, 'a')[0..10]
                user = User.create(email: @admin.email, cell_phone: @admin.cell_phone, confirmation_terms: true, role: @admin.role.to_i, password: pw, password_confirmation: pw)
                user.notification_new_user(pw)
                #UserMailer.welcome_email(user, pw).deliver
            
                @admin.update_columns(user_id: user.id)

                format.html { redirect_to admins_path, notice: 'Utilizador registado com sucesso.' }
                format.json { render :show, status: :created, location: @admin }
            else
                format.html { render :new }
                format.json { render json: @admin.errors, status: :unprocessable_entity }
            end
        end
    end

    def update
        respond_to do |format|
            user = User.find_by(email: @admin.email)
                        
            if @admin.update(admin_params)

                @admin.user.update_columns(email: @admin.email, cell_phone: @admin.cell_phone, role: @admin.role.to_i)

                format.html { redirect_to admin_path(@admin.id), notice: 'Administrador atualizado com sucess.' }
                format.json { render :show, status: :ok, location: @admin }
            else
                format.html { render :edit }
                format.json { render json: @admin.errors, status: :unprocessable_entity }
            end
        end
    end

    def destroy
        @admin.destroy
        redirect_to admins_path, notice: "Utilizador eliminado com sucesso."
    end

    def details
    end

    private
        def set_admin
            @admin = Admin.friendly.find(params[:id])
        end

        def admin_params
            params.require(:admin).permit(
                :name, :email, :cell_phone, :role, :slug, :avatar
            )
        end
end
