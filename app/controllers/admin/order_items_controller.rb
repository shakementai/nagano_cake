class Admin::OrderItemsController < ApplicationController
  def update
    @order_item = OrderItem.find(params[:id])
    if @order_item.update(order_item_params)
      redirect_to request referer
    end
  end
  
  private
  
  def order_item_params
    params.require(:order_item).permit(:production_status)
  end
end
