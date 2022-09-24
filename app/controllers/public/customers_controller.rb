class Public::CustomersController < ApplicationController
  def show
    @customer = Customer.find_by(id: current_customer.id)
  end

  def edit
    @customer = Customer.find_by(id: current_customer.id)
  end

  def update
    @customer = Customer.find_by(id: current_customer.id)
    if @customer.update(customer_params)
      redirect_to my_page_path
    else
      render :edit
    end
  end

  def unsubscribe
    @customer = Customer.find_by(id: current_customer.id)
  end

  def withdraw
    @customer = Customer.find_by(id: current_customer.id)
    @customer.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_kana_name, :first_kana_name, :post_code, :address, :phone_number, :email)
  end
end
