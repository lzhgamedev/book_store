class CartsController < ApplicationController
  before_action :authenticate
  before_action :set_cart, only: [:show, :edit, :update, :destroy]

  # GET /carts
  def index
    @carts = Cart.list(current_customer.id)
    @total = Cart.total(current_customer.id)
  end

  # GET /carts/1
  def show
  end

  # GET /carts/new
  def new
    @cart = Cart.new
  end

  # GET /carts/1/edit
  def edit
  end

  # POST /carts
  def create
    @cart = Cart.new(cart_params)
    @cart.customer_id = current_customer.id

    if @cart.save
      redirect_to carts_path
    else
      render action: 'edit'
    end
  end

  # PATCH/PUT /carts/1
  def update
    if @cart.update(cart_params)
      redirect_to carts_path
    else
      render action: 'edit'
    end
  end

  # DELETE /carts/1
  def destroy
    @cart.destroy
    redirect_to carts_path
  end

  def create_and
    if session[:cart_entry]
      cart_params = session[:cart_entry]
      cart_params[:customer_id] = current_customer.id

      cart = Cart.new(cart_params)
      cart.save
      session[:cart_entry] = nil
      flash[:show_cart] = true
    end
    redirect_to carts_path
  end

  def order
    Cart.checkout(current_customer.id)
    redirect_to thanks_carts_path
  end

  def thanks
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = Cart.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def cart_params
      params.require(:cart).permit(:book_id, :customer_id, :quantity)
    end

    def authenticate
      session[:cart_entry] = params[:cart]  if !customer_signed_in? && params[:cart]
      authenticate_customer!
    end
end
