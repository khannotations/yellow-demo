# frozen_string_literal: true

class PaymentsController < ApplicationController
  before_action :validate_customer

  def new
    load_customer
    load_telcos
    @payment = Payment.new(customer: @customer, phone: @customer.phone)
  end

  def create
    load_customer
    @payment = @customer.payments.new(create_payment_params)
    @payment.amount = @customer.registration_phone_price
    if @payment.save
      redirect_to pending_customer_payment_path(@customer, @payment)
    else
      load_telcos
      render :new
    end
  end

  def pending
    load_customer
    load_payment
  end

  def update
    load_payment
    @payment.update(update_payment_params)
    redirect_to customer_payment_path(@payment.customer, @payment), notice: 'Payment status updated'
  end

  def show
    load_customer
    load_payment
  end

  protected

  def load_customer
    @customer ||= Customer.find(params[:customer_id])
  end

  def load_payment
    @payment ||= Payment.find(params[:id])
  end

  def load_telcos
    @telcos = %w[MTN Airtel Vodafone TNM]
  end

  def create_payment_params
    params.require(:payment).permit(:phone, :telco)
  end

  def update_payment_params
    params.require(:payment).permit(:status)
  end
end
