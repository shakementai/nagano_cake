class Public::OrdersController < ApplicationController
  def new
    @deliveries = Delivery.where(customer_id: current_customer.id)
    @order = Order.new
  end

  def confirm
    cart = current_customer.cart_items
    @cart_items = cart.all
    @total_price = 0
    if params[:order][:select_address] == "0"
      @order = Order.new(order_params)
      @order.post_code = current_customer.post_code
      @order.address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name
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
    @order = Order.new(order_params)
    @order.save
    redirect_to complete_path
  end

  def complete

  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_items = OrderItem.all
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :post_code, :address, :name, :shipping_cost, :customer_id, :total_price, :order_status  )
  end

end
