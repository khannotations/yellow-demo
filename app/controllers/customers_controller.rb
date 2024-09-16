# frozen_string_literal: true

class CustomersController < ApplicationController
  def new
    load_currencies
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      redirect_to new_customer_phone_path(@customer)
    else
      load_currencies
      render :new
    end
  end

  protected

  def load_currencies
    @currencies = %w[
      USD MWK KES UGX RWF
    ].sort
    @default_currency = 'USD'
  end

  def customer_params
    params.require(:customer)
          .permit(:first_name, :last_name, :phone, :id_number, :birthday,
                  :registration_phone_price_cents, :registration_phone_price_currency)
  end
end
