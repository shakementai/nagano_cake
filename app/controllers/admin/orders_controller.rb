class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end
  
  def update
    @order = Order.find(params[:id])
    @order_item = @order.order_items
    if @order.update(order_params)
      if @order.order_status == "payment_confirmation"
        @order_item.update(production_status:1)
      elsif  @order.order_status == "product_complete"
        @order_item.update(production_status:2)
      end
      redirect_to request.referer
    end
  end

  def index
    @customer = Customer.find(params[:id])
    @orders = @customer.orders.page(params[:page]).per(10)
  end

  private
  
  def order_params
    params.require(:order).permit(:order_status)
  end
  
end
