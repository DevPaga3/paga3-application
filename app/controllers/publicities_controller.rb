class PublicitiesController < ApplicationController
  before_action :set_publicity, only: [:show, :edit, :update, :destroy, :show_pub_on_client]

  # GET /publicities
  # GET /publicities.json
  def index
    @pagy, @publicities = pagy(Publicity.where.not(description: nil), items: 10)
  end

  # GET /publicities/1
  # GET /publicities/1.json
  def show
    @publicities = Publicity.all
    @publicitiesIsActive = Publicity.all.where(status: true)
    @publicitiesIsDisable = Publicity.all.where(status: false)
  end

  # GET /publicities/new
  def new
    @publicity = Publicity.new
  end

  def show_pub_on_client
    @publicity.show_pub_on_client
    redirect_to @publicity, notice: 'Publicidade ativada para o cliente.'
  end

  # GET /publicities/1/edit
  def edit
  end

  # POST /publicities
  # POST /publicities.json
  def create
    @publicity = Publicity.new(publicity_params)

    respond_to do |format|
      if @publicity.save
        format.html { redirect_to @publicity, notice: 'Publicidade criada com sucesso.' }
        format.json { render :show, status: :created, location: @publicity }
      else
        format.html { render :new }
        format.json { render json: @publicity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /publicities/1
  # PATCH/PUT /publicities/1.json
  def update
    respond_to do |format|
      if @publicity.update(publicity_params)
        format.html { redirect_to @publicity, notice: 'Publicidade atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @publicity }
      else
        format.html { render :edit }
        format.json { render json: @publicity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /publicities/1
  # DELETE /publicities/1.json
  def destroy
    @publicity.destroy
    respond_to do |format|
      format.html { redirect_to publicities_url, notice: 'Publicidade eliminada com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_publicity
      @publicity = Publicity.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def publicity_params
      params.require(:publicity).permit(:avatar, :description, :status, :start_date, :end_date)
    end

    def publicity_params_new
      params.require(:publicity).permit(:avatar, :description, :start_date, :end_date)
    end
end
