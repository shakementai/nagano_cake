class Public::OrdersController < ApplicationController
  def new
  end

  def complete
    
  end

  def index
    @orders = Order.all
  end

  def show
  end
end
