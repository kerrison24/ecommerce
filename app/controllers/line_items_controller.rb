class LineItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:create]

  def create
    product = Product.find(params[:product_id])
    @line_item = @cart.line_items.build(product: product)

    if @line_item.save
      flash[:message] = 'Item was successfully added.'
      redirect_to @line_item.cart
    else
      render action: 'new'
    end
  end
end
