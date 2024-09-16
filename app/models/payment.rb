# frozen_string_literal: true

# == Schema Information
#
# Table name: payments
#
#  id              :bigint           not null, primary key
#  customer_id     :bigint           not null
#  amount_cents    :integer          default(0), not null
#  amount_currency :string           default("USD"), not null
#  status          :string           default("pending"), not null
#  phone           :string
#  telco           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Payment < ApplicationRecord
  monetize :amount_cents, numericality: {
    greater_than_or_equal_to: 0
  }

  belongs_to :customer

  validates :status, :amount, :phone, :telco, presence: true
  validates_inclusion_of :status, in: %w[pending paid failed], message: 'must be pending, paid or failed'

  def pending?
    status == 'pending'
  end

  def paid?
    status == 'paid'
  end

  def failed?
    status == 'failed'
  end
end
