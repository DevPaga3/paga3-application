class ConfigurationsController < ApplicationController
  before_action :set_config, only: [:show, :edit, :update]
  #load_and_authorize_resource
  
  def edit
  end

  def update
      respond_to do |format|
        if @config.update(config_params)
          format.html { redirect_to configuration_path(@config), notice: 'Configuração actualizada com sucesso.' }
          format.json { render :show, status: :ok, location: @config }
        else
          format.html { render :edit }
          format.json { render json: @config.errors, status: :unprocessable_entity }
        end
      end
  end


      
  def show
    @bank = Bank.new
  end

  private
      def set_config
        #@config = Configuration.friendly.find(params[:id])

          @config = current_user.config
      end

      def config_params
          params.require(:configuration).permit(
            :logo, :name, :effort_rate, 
            :cell_phone, :email, :address, 
            :nif, :version, :nipc, :iec, :province, :municipality 
          )
      end

end
