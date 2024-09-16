# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def validate_customer
    load_customer
    return if @customer.approved?

    redirect_to new_customer_path, alert: "Customer #{params[:customer_id]} is not approved"
  end
end
