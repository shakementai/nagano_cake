class Admin::OrderItemsController < ApplicationController
  def update
    @order_item = OrderItem.find(params[:id])
    @order = Order.find(params[:order_id])
    if @order_item.update(order_item_params)
      if @order_item.production_status == "producting"
        @order.update(order_status:2)
      elsif @order.order_items.count == @order.order_items.where(production_status: "product_complete").count
        @order.update(order_status:3)
      end
      redirect_to request.referer
    end
  end

  private

  def order_item_params
    params.require(:order_item).permit(:production_status)
  end
end
