class Public::CartItemsController < ApplicationController

  def create
    @cart_item = CartItem.new(cart_item_params)
    if @cart_item.save
      redirect_to cart_items_path
    else
      @item = Item.find(params[:id])
      @genres = Genre.all
      render "items/show"
    end

  end

  def index
    cart = current_customer.cart_items
    @cart_items = cart.all
    @total_plice = 0
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(amount: params[:amount])
    redirect_to cart_items_path
  end

  def destroy
    item = Item.find(params[:id])
    CartItem.find_by(item_id: item.id).destroy
    redirect_to cart_items_path
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount, :customer_id)
  end
end
