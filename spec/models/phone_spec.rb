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
require 'rails_helper'

RSpec.describe Phone, type: :model do
  describe 'imei' do
    subject { build(:phone) }
    it { is_expected.to be_valid }

    context 'when imei is too short' do
      subject { build(:phone, imei: '123123') }
      it { is_expected.to be_invalid }
    end

    context 'when imei contains letters' do
      subject { build(:phone, imei: '123x123x123') }
      it { is_expected.to be_invalid }
    end
  end
end
