class Public::OrdersController < ApplicationController
  def new
    @deliveries = Delivery.where(customer_id: current_customer.id)
  end

  def confirm
    cart = current_customer.cart_items
    @cart_items = cart.all
    @total_plice = 0
    @order = Order.new(order_params)
    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
    @order.name = current_customer.first_name + current_customer.last_name
  end

  def complete

  end

  def index

  end

  def index
  end

  def show
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :post_code, :address, :name  )
  end

end
