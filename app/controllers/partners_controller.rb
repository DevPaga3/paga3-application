class PartnersController < ApplicationController
  before_action :set_partner, only: [:show, :edit, :update, :destroy, :show_and_hide_partner]

  # GET /partners
  # GET /partners.json
  def index
    @pagy, @partners = pagy(Partner.where.not(name: nil), items: 10)
  end

  # GET /partners/1
  # GET /partners/1.json
  def show
  end

  # GET /partners/new
  def new
    @partner = Partner.new
  end

  # Show partner in site
  def show_and_hide_partner
    @partner.show_and_hide_partner
    redirect_to @partner, notice: 'Informação do parceiro adicionada no site.'
  end

  # GET /partners/1/edit
  def edit
  end

  # POST /partners
  # POST /partners.json
  def create
    @partner = Partner.new(partner_params)

    respond_to do |format|
      if @partner.save
        format.html { redirect_to @partner, notice: 'Parceiro criado com sucesso.' }
        format.json { render :show, status: :created, location: @partner }
      else
        format.html { render :new }
        format.json { render json: @partner.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /partners/1
  # PATCH/PUT /partners/1.json
  def update
    respond_to do |format|
      if @partner.update(partner_params)
        format.html { redirect_to @partner, notice: 'Dados do parceiro atualizados com sucesso.' }
        format.json { render :show, status: :ok, location: @partner }
      else
        format.html { render :edit }
        format.json { render json: @partner.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /partners/1
  # DELETE /partners/1.json
  def destroy
    @partner.destroy
    respond_to do |format|
      format.html { redirect_to partners_url, notice: 'Parceiro atualizado com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_partner
      @partner = Partner.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def partner_params
      params.require(:partner).permit(:avatar, :name, :status)
    end

    def partner_params_new
      params.require(:partner).permit(:avatar, :name, :status)
    end
end
