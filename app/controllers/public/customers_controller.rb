class Public::CustomersController < ApplicationController
  def show
    @customer = Customer.find_by(id: current_customer.id)
  end

  def edit
  end
end
