class RequestsController < ApplicationController
  before_action :set_request, only: %i[ 
    show 
    edit 
    update 
    destroy 
    cancel_my_request
    approve_request
    confirmation_request
  ]

  # GET /requests or /requests.json
  def index
    @requests = Request.all
  end

  def my_requests
    @profile = current_user.profile
    @requests = current_user.profile.requests
  end

  # GET /requests/1 or /requests/1.json
  def show
  end

  # GET /requests/new
  def new
    @request = Request.new
  end

  # GET /requests/1/edit
  def edit
  end

  def cancel_my_request
    @request.update_columns(status: 5)
    redirect_to my_requests_path, notice: "Solicitação Cancelada com sucesso."
  end

  def approve_request
    @request.approve_request
    redirect_to requests_path, notice: "Solicitação Aprovada com sucesso."
  end

  def confirmation_request
    @request.confirmation_request(current_user)
    redirect_to my_requests_path, notice: "Solicitação Confirmada com sucesso Pelo cliente."
  end

  # POST /requests or /requests.json
  def create
    @request = Request.new(request_params)
    @request.profile_id = current_user.profile.id

    respond_to do |format|
      if @request.save
        format.html { redirect_to my_requests_path, notice: "Solicitação enviada com sucesso." }
        format.json { render :show, status: :created, location: @request }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /requests/1 or /requests/1.json
  def update
    respond_to do |format|
      if @request.update(request_params)
        format.html { redirect_to current_user.admin? ? requests_path : my_requests_path, notice: "Solicitação ajustada com sucesso." }
        format.json { render :show, status: :ok, location: @request }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requests/1 or /requests/1.json
  def destroy
    @request.destroy
    respond_to do |format|
      format.html { redirect_to requests_url, notice: "Solicitação apagada com sucesso" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_request
      @request = Request.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def request_params
      params.require(:request).permit(:profile_id, :store, :address, :cell_phone, :email, :product, :price, :render_number, :status)
    end
end
