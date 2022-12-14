class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    if current_customer.cart_items.blank?
      redirect_to cart_items_path
    end
    @deliveries = Delivery.where(customer_id: current_customer.id)
    @order = Order.new
    #確認画面をリロードした際のエラー回避
    if request.path.include?("confirm")
      redirect_to new_order_path
      flash[:alert] = "確認画面の更新はできません"
    end
  end

  def confirm
    cart = current_customer.cart_items
    @cart_items = cart.all
    @total_price = 0
    #ラジオボタンでの条件分岐
    if params[:order][:select_address] == "0"
      @order = Order.new(order_params)
      @order.post_code = current_customer.post_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:select_address] == "1"
      @order = Order.new(order_params)
      @address = Delivery.find(params[:order][:delivery_id])
      @order.post_code = @address.post_code
      @order.address = @address.address
      @order.name = @address.name
    else
      @order = Order.new(order_params)
      #空白なら同じページに返す
      if params[:order][:post_code].blank? || params[:order][:address].blank? || params[:order][:name].blank?
        flash[:alert] = "配送先が正しく入力されていません"
        redirect_to new_order_path
      end
    end
  end

  def create
    #カート内商品を定義
    cart_items = current_customer.cart_items.all

    @order = Order.new(order_params)
    @order.save

    #カートアイテムを個別に取り出してオーダーアイテムに保存
    cart_items.each do |cart_item|
      order_item = OrderItem.new
      order_item.order_id = @order.id
      order_item.item_id = cart_item.item_id
      order_item.amount = cart_item.amount
      order_item.purchase_price = cart_item.item.with_tax_price
      order_item.save
    end
    redirect_to complete_path
    cart_items.destroy_all
  end

  def complete

  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
    @item_all_price = @order.total_price - @order.shipping_cost
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :post_code, :address, :name, :shipping_cost, :customer_id, :total_price, :order_status  )
  end

end
