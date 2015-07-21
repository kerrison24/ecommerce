class CartController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:show, :edit, :update, :destroy]
  def index
  end

  def show
    @cart = Cart.find(params[:id])
  end

  def edit
  end
end
