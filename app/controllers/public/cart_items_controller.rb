class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def create
    @cart_item = CartItem.new(cart_item_params)
    @item = Item.find_by(id: @cart_item.item_id)

    if current_customer.cart_items.find_by(item_id: @item.id).present?
      cart_item = current_customer.cart_items.find_by(item_id: @item.id)
      cart_item.amount += @cart_item.amount.to_i
      if cart_item.amount > 10
        flash[:alert] = "購入上限は10点です"
        redirect_to item_path(@item)
      elsif @cart_item.amount.to_i == 0
        flash[:alert] = "個数が選択されていません"
        redirect_to item_path(@item)
      else
        cart_item.save
        redirect_to cart_items_path
      end
    elsif@cart_item.save
      redirect_to cart_items_path
    else
      flash[:alert] = "個数が選択されていません"
      redirect_to item_path(@item)
    end

  end

  def index
    @cart = current_customer.cart_items
    @cart_items = @cart.all
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
