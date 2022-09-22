class Public::OrdersController < ApplicationController
  def new
    @deliveries = Delivery.where(customer_id: current_customer.id)
    @order = Order.new
  end

  def confirm
    cart = current_customer.cart_items
    @cart_items = cart.all
    @total_price = 0
    @order = Order.new(order_params)
    # @order.postal_code = current_customer.postal_code
    # @order.address = current_customer.address
    # @order.name = current_customer.first_name + current_customer.last_name
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
    @order_items = OrderItems.all
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :post_code, :address, :name, :shipping_cost, :customer_id, :total_price, :order_status  )
  end

end
