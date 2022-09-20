class Public::CartItemsController < ApplicationController

  def create
    @cart_item = CartItem.new(cart_item_params)
    if @cart_item.save
      redirect_to cart_items_path
    else
      redirect_to items_path(params[:item_id])
    end

  end

  def index
    cart = current_customer.cart_items
    @cart_items = cart.all
    # @total_plice = self.
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount, :customer_id)
  end
end
