# frozen_string_literal: true

# == Schema Information
#
# Table name: payments
#
#  id              :bigint           not null, primary key
#  customer_id     :bigint           not null
#  amount_cents    :integer          default(0), not null
#  amount_currency :string           default("USD"), not null
#  status          :string
#  phone           :string
#  telco           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require 'rails_helper'

RSpec.describe Payment, type: :model do
  describe 'amount' do
    context 'when amount is positive' do
      subject { build(:payment, amount: 100) }
      it { is_expected.to be_valid }
    end

    context 'when amount is negative' do
      subject { build(:payment, amount: -100) }
      it { is_expected.to be_invalid }
    end
  end
end
