class Public::OrdersController < ApplicationController
  def new
    @deliveries = Delivery.where(customer_id: current_customer.id)
    @order = Order.new
  end

  def complete

  end

  def index
  end

  def show
  end

  # private

  # def order_params
  #   params.require(:order).permit(:customer_id, :post_code, :address, :name, :payment_method )
  # end

end
