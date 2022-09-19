class Public::DeliveriesController < ApplicationController
  def index
    @delivery = Delivery.new
    @deliveries = Delivery.all
  end

  def edit
  end

  def create
    @delivery = Delivery.new(delivery_params)
    @delivery.customer_id = current_customer.id
    @delivery.save
    redirect_to request.referer
  end

  private

  def delivery_params
    params.require(:delivery).permit(:post_code, :address, :name)
  end
end
