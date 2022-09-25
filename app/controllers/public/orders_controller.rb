class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @deliveries = Delivery.where(customer_id: current_customer.id)
    @order = Order.new
    if request.path.include?("confirm")
      redirect_to new_order_path
      flash[:alert] = "確認画面の更新はできません"
    elsif current_customer.cart_items.blank?
      redirect_to cart_items_path
    end
  end

  def confirm
    cart = current_customer.cart_items
    @cart_items = cart.all
    @total_price = 0
    if params[:order][:select_address] == "0"
      @order = Order.new(order_params)
      @order.post_code = current_customer.post_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:select_address] == "1"
      @order = Order.new(order_params)
      @address = Delivery.find(params[:order][:delivery_id])
      @order.post_code = @address.post_code
      @order.address = @address.address
      @order.name = @address.name
    else
      @order = Order.new(order_params)
    end
  end

  def create
    cart_items = current_customer.cart_items.all
    @order = Order.new(order_params)
    @order.save
    cart_items.each do |cart_item|
      order_item = OrderItem.new
      order_item.order_id = @order.id
      order_item.item_id = cart_item.item_id
      order_item.amount = cart_item.amount
      order_item.purchase_price = cart_item.item.with_tax_price
      order_item.save
    end
    redirect_to complete_path
    cart_items.destroy_all
  end

  def complete

  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
    @item_all_price = @order.total_price - @order.shipping_cost
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :post_code, :address, :name, :shipping_cost, :customer_id, :total_price, :order_status  )
  end

end
