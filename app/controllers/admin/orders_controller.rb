class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  def show
    @order = Order.find(params[:id])
  end
  
  def update
    @order = Order.find(params[:id])
    @order.save(order_params)
    redirect_to request.referer
  end

  def index
    @customer = Customer.find(params[:id])
    @orders = Order.page(params[:page]).per(10)
  end

  private
  
  def order_params
    params.require(:order).permit(:order_status)
  end
  
end
