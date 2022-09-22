class Public::HomesController < ApplicationController
  def top
    @items = Item.all.order(created_at: :desc)
    @orders = Order.all
  end

  def about
  end
end
