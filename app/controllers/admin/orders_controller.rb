class Admin::OrdersController < ApplicationController
  def show
  end
  
  def index
    @customer = Customer.find(params[:id])
    @orders = Order.page(params[:page]).per(10)
  end
  
end
