class OccupationAreasController < ApplicationController
  before_action :set_occupation_area, only: [:show, :edit, :update, :destroy]

  # GET /occupation_areas
  # GET /occupation_areas.json
  def index
    @occupation_area = OccupationArea.new
    @occupation_areas = OccupationArea.all
  end

  # GET /occupation_areas/1
  # GET /occupation_areas/1.json
  def show
  end

  # GET /occupation_areas/new
  def new
    @occupation_area = OccupationArea.new
  end

  # GET /occupation_areas/1/edit
  def edit
  end

  # POST /occupation_areas
  # POST /occupation_areas.json
  def create
    @occupation_area = OccupationArea.new(occupation_area_params)

    respond_to do |format|
      if @occupation_area.save
        format.html { redirect_to occupation_areas_url, notice: 'Área de atuação criada com sucesso.' }
        format.json { render :show, status: :created, location: @occupation_area }
      else
        format.html { render :new }
        format.json { render json: @occupation_area.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /occupation_areas/1
  # PATCH/PUT /occupation_areas/1.json
  def update
    respond_to do |format|
      if @occupation_area.update(occupation_area_params)
        format.html { redirect_to @occupation_area, notice: 'Área de atuação atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @occupation_area }
      else
        format.html { render :edit }
        format.json { render json: @occupation_area.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /occupation_areas/1
  # DELETE /occupation_areas/1.json
  def destroy
    @occupation_area.destroy
    respond_to do |format|
      format.html { redirect_to occupation_areas_url, notice: 'Área de atuação removida com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_occupation_area
      @occupation_area = OccupationArea.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def occupation_area_params
      params.require(:occupation_area).permit(:occupation, :description, :status)
    end
end
