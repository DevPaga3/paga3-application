class StoresController < ApplicationController
  
  before_action :set_store, only: [
    :show, 
    :edit, 
    :update, 
    :destroy, 
    :consult_request, 
    :add_product_to_list, 
    :details_of_current_order, 
    :remove_item_order, 
    :validate_cart, 
    :validate_code_and_finish,
    :invoice_details
  ]
  before_action :set_pre_order, only: [ 
    :add_product_to_list, 
    :details_of_current_order, 
    :remove_item_order, 
    :validate_cart, 
    :validate_code_and_finish 
  ]
  before_action :set_item_order, only: [ :remove_item_order ]
  before_action :set_factura, only: [ :invoice_details ]

  load_and_authorize_resource
  
  # GET /stores
  # GET /stores.json
  def index
    @store = Store.new(company_id: current_user.company_id)

    @stores = current_user.company.stores
  end

  # GET /stores/1
  # GET /stores/1.json
  def show
    @product = Product.new(store_id: @store.id)
  end

  def details_of_current_order
    
  end


  def consult_request   
    search = params["search"]
    user = User.find_by(cell_phone: search["cell_phone"]) if params["search"].present?
    
    if user.present?
        @pre_order = PreOrder.create(profile_id: user.profile.id, store_id: @store.id)
        redirect_to details_of_current_order_path(pre_order_id: @pre_order.id)
    else
        redirect_to @store, alert: 'Cliente não encontrado'
    end
  end

  def validate_cart
    @pre_order.profile.user.create_code_validation
  end

  def invoice_details
    
  end


  def validate_code_and_finish
    validation_code = params["validation_code"]

    if validation_code["code"].present?
        purchase_code = @pre_order.profile.user.purchase_codes.where(is_active: true).where(code: validation_code["code"]).first

        if purchase_code
            purchase_code.finish
            @pre_order.create_invoice(current_user)
            redirect_to @store, notice: 'Compra realizada com sucesso'
        else
            redirect_to validate_cart_path(pre_order_id: @pre_order.id), notice: 'Código não valido'
        end
    else
        redirect_to validate_cart_path(pre_order_id: @pre_order.id), alert: 'Código não valido'
    end

  end


  def add_product_to_list
    search = params["search"]
    product = nil

    if search["product_id"].present?
      product = Product.find(search["product_id"])
    else
      redirect_to details_of_current_order_path(pre_order_id: @pre_order.id), alert: 'Produto não encontrado'
    end


    if product.present?
      if (@pre_order.profile.purchase_amount >= product.first_parcel) # && (@pre_order.total_to_pay + product.price_with_commission) <= @pre_order.profile.purchase_amount)
          ItemOrder.create(product_id: product.id, pre_order_id: @pre_order.id)
          redirect_to details_of_current_order_path(pre_order_id: @pre_order.id), notice: 'Produto adicionado com sucesso'
      else
        redirect_to details_of_current_order_path(pre_order_id: @pre_order.id), alert: 'Valor do cliente não é suficiente para completar a compra'
      end

    end
  end




  # GET /stores/new
  def new
    @store = Store.new
  end

  # GET /stores/1/edit
  def edit
  end

  # POST /stores
  # POST /stores.json
  def create
    @store = Store.new(store_params)

    respond_to do |format|
      if @store.save
        format.html { redirect_to @store, notice: 'Loja registada com sucesso.' }
        format.json { render :show, status: :created, location: @store }
      else
        format.html { render :new }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stores/1
  # PATCH/PUT /stores/1.json
  def update
    respond_to do |format|
      if @store.update(store_params)
        format.html { redirect_to @store, notice: 'Loja atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @store }
      else
        format.html { render :edit }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stores/1
  # DELETE /stores/1.json
  def destroy
    @store.destroy
    respond_to do |format|
      format.html { redirect_to stores_path, notice: 'Loja eliminada com sucesso.' }
      format.json { head :no_content }
    end
  end

  def remove_item_order
    @item_order.destroy

    redirect_to details_of_current_order_path(pre_order_id: @pre_order.id)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_store
      @store = Store.friendly.find(params[:id])
    end

    def set_factura
      @factura = Factura.friendly.find(params[:factura_id])
    end

    def set_pre_order
      @pre_order = PreOrder.find(params[:pre_order_id])
    end

    def set_item_order
      @item_order = ItemOrder.find(params[:item_order_id])
    end

    # Only allow a list of trusted parameters through.
    def store_params
      params.require(:store).permit(:name, :reference_number, :description, :location, :company_id, :category_id)
    end
end
