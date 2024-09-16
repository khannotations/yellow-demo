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
require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'birthday' do
    context 'when birthday is present' do
      subject { build(:customer, birthday: 30.years.ago) }
      it { is_expected.to be_valid }
    end

    context 'when birthday is not present' do
      subject { build(:customer, birthday: nil) }
      it { is_expected.to be_invalid }
    end

    context 'when birthday too young' do
      subject { build(:customer, birthday: 17.years.ago) }
      it { is_expected.to be_invalid }
    end

    context 'when birthday too old' do
      subject { build(:customer, birthday: 66.years.ago) }
      it { is_expected.to be_invalid }
    end
  end

  describe 'ID number' do
    context 'when it is unique' do
      subject { build(:customer) }
      it { is_expected.to be_valid }
    end

    context 'when it is not unique' do
      let(:previous_customer) { create(:customer) }
      subject { build(:customer, id_number: previous_customer.id_number) }
      it { is_expected.to be_invalid }
    end
  end

  describe 'approved_at' do
    subject { build(:customer) }
    it { is_expected.to_not be_approved }
    it 'approves after create' do
      subject.save
      expect(subject).to be_approved
    end
  end

  describe 'registration_phone_price' do
    context 'when price is positive' do
      subject { build(:customer, registration_phone_price: 100) }
      it { is_expected.to be_valid }
    end

    context 'when price is negative' do
      subject { build(:customer, registration_phone_price: -100) }
      it { is_expected.to be_invalid }
    end
  end
end
