# frozen_string_literal: true

# == Schema Information
#
# Table name: phones
#
#  id          :bigint           not null, primary key
#  customer_id :bigint           not null
#  imei        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Phone < ApplicationRecord
  belongs_to :customer

  validates :imei, presence: true, uniqueness: true,
                   format: { with: /\A([0-9]){10,}\z/, message: 'must be 10 or more digits only' }
end
