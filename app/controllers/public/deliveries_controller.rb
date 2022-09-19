class Public::DeliveriesController < ApplicationController
  def index
    @delivery = Delivery.new
    @deliveries = Delivery.all
  end

  def edit
  end
  
  def create
    @delivery = Delivary.new(delivery_params)
    redirect_to request.referer
  end
  
  private
  
  def delivery_params
    params.require(:derivary).permit(:post_code, :address, :name)
  end
end
