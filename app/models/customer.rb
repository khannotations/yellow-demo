# frozen_string_literal: true

# == Schema Information
#
# Table name: customers
#
#  id                                :bigint           not null, primary key
#  first_name                        :string
#  last_name                         :string
#  id_number                         :string
#  birthday                          :date
#  approved_at                       :datetime
#  registration_phone_price_cents    :integer          default(0), not null
#  registration_phone_price_currency :string           default("USD"), not null
#  created_at                        :datetime         not null
#  updated_at                        :datetime         not null
#
class Customer < ApplicationRecord
  monetize :registration_phone_price_cents, numericality: { greater_than: 0 }

  has_many :phones
  has_many :payments

  validates :first_name, :last_name, :phone, :id_number, :birthday, presence: true
  validates :id_number, uniqueness: true
  validate :birthday_in_range

  after_create :set_approved_at

  def full_name
    "#{first_name} #{last_name}"
  end

  def approved?
    approved_at.present?
  end

  def birthday_in_range
    return unless birthday.present? && (birthday > 18.years.ago.to_date || birthday < 65.years.ago.to_date)

    errors.add(:birthday, 'must be 18 to 65 years ago')
  end

  def set_approved_at
    update(approved_at: Time.current)
  end
end
