class BanksController < ApplicationController
  before_action :set_bank, only: [:edit, :update, :destroy, :show]
  load_and_authorize_resource
  
  def index
    @bank = Bank.new
    @banks = Bank.all
  end
  # GET /banks/new
  def new
    @bank = Bank.new
  end

  def show
    
  end

  # GET /banks/1/edit
  def edit
  end

  def create
    @bank = Bank.new(bank_params)

    respond_to do |format|
      if @bank.save
        format.html { redirect_to banks_path, notice: 'Banco registado com sucesso.' }
        format.json { render :show, status: :created, location: @bank }
      else
        format.html { render :new }
        format.json { render json: @bank.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /banks/1
  # PATCH/PUT /banks/1.json
  def update
    respond_to do |format|
      if @bank.update(bank_params)
        format.html { redirect_to configuration_path(@bank.config), notice: 'Banco atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @bank }
      else
        format.html { render :edit }
        format.json { render json: @bank.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /banks/1
  # DELETE /banks/1.json
  def destroy
    @bank.destroy
    respond_to do |format|
      format.html { redirect_to banks_path, notice: 'Banco removido com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    def set_bank
      @bank = Bank.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bank_params
      params.require(:bank).permit(:name, :sigla, :account, :iban, :status, :swift, :website)
    end
end
