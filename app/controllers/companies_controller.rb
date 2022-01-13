class CompaniesController < ApplicationController
        
    before_action :set_comapny, only: [
        :details, 
        :edit, 
        :update, 
        :show, 
        :destroy, 
        :show_and_hidden_in_site, 
        :associate_user_company,
        :reset_password_company_user
    ]
    
    load_and_authorize_resource
    
    def index
        if params[:search]
            @pagy, @companies = pagy(Company.search(params[:search]).where.not(name: nil).order('created_at DESC'), items: 10)
        else
            @pagy, @companies = pagy(Company.where.not(name: nil).order('created_at DESC'), items: 10)
        end
    end

    def edit
    end

    def reset_password_company_user
        if @company.user.present?
            @company.reset_password
            redirect_to @company, notice: 'Nova senha enviada com sucesso.'          
        else
            redirect_to @company, alert: 'Lamentamos mas não há utilizador associado a esta empresa.'
        end
    end

    def show
    end

    def new
        @company = Company.new
    end

    def associate_user_company
        @company.create_access_user
        redirect_to @company, notice: 'Mensagem enviada com sucesso.'
    end

    def show_and_hidden_in_site
        @company.show_and_hidden_in_site
        redirect_to @company, notice: 'Informação da Empresa actualizada no site.'
    end

    def create
        @company = Company.new(company_params_new)

        respond_to do |format|
            if @company.save
                @company.create_access_user
                format.html { redirect_to @company, notice: 'Empresa registada com sucesso.' }
                format.json { render :show, status: :created, location: @company }
            else
                format.html { render :new }
                format.json { render json: @company.errors.messages, status: :unprocessable_entity }
            end
        end
    end


    def update
        respond_to do |format|
            #@company.email = @company.user.email
            @company.create_access_user

            if @company.update(company_params)
                format.html { redirect_to comapnies_details_path(@company.id), notice: 'Empresa atualizada com sucesso.' } if current_user.company?
                format.html { redirect_to company_path(@company), notice: 'Empresa atualizada com sucesso.' } if current_user.admin?
                format.json { render :show, status: :ok, location: @company }
            else
                p @company.errors.messages
                format.html { render :edit }
                format.json { render json: @company.errors, status: :unprocessable_entity }
            end
        end
    end


    def details
    end

    def destroy
        user =  @company.user

        if user.is_active?
            user.inactive_user
        else
            user.active_user
        end

        if @company.present?
            @company.destroy
            user.delete if user.present?
        end


        respond_to do |format|
            format.html { redirect_to companies_path, notice: 'Empresa eliminada com sucesso.' }
            format.json { head :no_content }
        end
    end

    private
        def set_comapny
            @company = Company.friendly.find(params[:id])
        end

        def company_params
            params.require(:company).permit(
                :avatar, :name, :nif, :address, :cell_phone, :category_id,
                :accountNumber, :iban, :user_id
            )
        end

        def company_params_new
            params.require(:company).permit(
                :avatar, :name, :nif, :address, :cell_phone, :email, :category_id,
                :accountNumber, :iban, :user_id
            )
        end
end
