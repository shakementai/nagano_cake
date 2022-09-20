class Public::CustomersController < ApplicationController
  def show
    @customer = Customer.find_by(id: current_customer.id)
  end

  def edit
    @customer = Customer.find_by(id: current_customer.id)
  end

  def update
    @customer = Customer.find_by(id: current_customer.id)
    @customer.update(customer_params)
    redirect_to my_page_path(@customer.id)
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_kana_name, :first_kana_name, :post_code, :address, :phone_number, :email)
  end
end
