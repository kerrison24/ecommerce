class CartController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:show, :edit, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart
  def index
  end

  def show
    @cart = Cart.find(params[:id])
  end

  def edit
  end

  def destroy
    @cart.destroy if @cart.id == session[:cart_id]
    session[:cart_id] = nil
    flash[:success] = 'Your cart is currently empty'
    redirect_to store_url
  end

  private
    def invalid_cart
      logger.error "Attempt to access invalid cart #{params[:id]}"
      flash[:error] = 'Invalid cart'
      redirect_to store_url
    end
end
