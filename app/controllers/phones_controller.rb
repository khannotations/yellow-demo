# frozen_string_literal: true

class PhonesController < ApplicationController
  before_action :validate_customer

  def new
    load_customer
    @phone = Phone.new(customer: @customer)
  end

  def create
    @phone = Phone.new(phone_params)
    if @phone.save
      redirect_to new_customer_payment_path(@customer)
    else
      load_customer
      render :new
    end
  end

  protected

  def load_customer
    @customer ||= Customer.find(params[:customer_id])
  end

  def phone_params
    params.require(:phone).permit(:imei).merge(customer: @customer)
  end
end
