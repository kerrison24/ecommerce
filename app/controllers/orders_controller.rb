class OrdersController < ApplicationController
  skip_before_action :authorize, only: [:new, :create]
  include CurrentCart
  before_action :set_cart, only: [:new, :create]

  def new
    if @cart.line_items.empty?
      flash[:error] = "Your cart is empty"
      redirect_to store_url
      return
    end
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.add_line_items_from_cart(@cart)
    if @order.save
      Cart.destroy(session[:cart_id])
      session[:cart_id] = nil
      OrderNotifier.received(@order).deliver
      flash[:success] = "Thank you for your order"
      redirect_to store_url
    else
      render action: 'new'
    end
  end

  def index
    @orders = Order.all
    @products = Product.all
  end

  private
    def order_params
      params.require(:order).permit(:name, :address, :pay_type, :email)
    end
end
