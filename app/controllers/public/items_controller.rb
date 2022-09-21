class Public::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page])
    @items_all = Item.all
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @genres = Genre.all
  end
  
  def search
    @items = Item.search(params[:word]).page(params[(:page)])
    @word = params[:word]
    @items_all = Item.search(params[:word])
    @genres = Genre.all
    render :index
  end
end
