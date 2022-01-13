class MovimentsController < ApplicationController
  before_action :set_moviment, only: %i[ show edit update destroy ]
  before_action :set_profile, only: %i[ new ]

  # GET /moviments or /moviments.json
  def index
    @moviments = Moviment.all
  end

  # GET /moviments/1 or /moviments/1.json
  def show
  end

  # GET /moviments/new
  def new
    @moviment = Moviment.new
  end

  # GET /moviments/1/edit
  def edit
  end

  # POST /moviments or /moviments.json
  def create
    @moviment = Moviment.new(moviment_params)

    @moviment.user_id = current_user.id

    respond_to do |format|
      if @moviment.save
        @moviment.profile.update_purchase_amount

        format.html { redirect_to @moviment.profile, notice: "Movimento registado com sucesso." }
        format.json { render :show, status: :created, location: @moviment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @moviment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /moviments/1 or /moviments/1.json
  def update
    respond_to do |format|
      if @moviment.update(moviment_params)
        format.html { redirect_to @moviment, notice: "Moviment was successfully updated." }
        format.json { render :show, status: :ok, location: @moviment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @moviment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /moviments/1 or /moviments/1.json
  def destroy
    @moviment.destroy
    respond_to do |format|
      format.html { redirect_to moviments_url, notice: "Moviment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_moviment
      @moviment = Moviment.find(params[:id])
    end

    def set_profile
      @profile = Profile.find(params[:profile])
    end

    # Only allow a list of trusted parameters through.
    def moviment_params
      params.require(:moviment).permit(:is_credit, :amount, :profile_id, :user_id)
    end
end

