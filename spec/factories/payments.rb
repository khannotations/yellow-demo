# frozen_string_literal: true

FactoryBot.define do
  factory :payment do
    amount { Money.new(Forgery('basic').number * 111, 'USD') }
    status { 'pending' }
    phone { '307543415456705' }
    telco { 'Tigo' }
    association :customer
  end
end
