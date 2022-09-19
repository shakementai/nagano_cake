class Public::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page])
    @items_all = Item.all
  end

  def show
  end
end
