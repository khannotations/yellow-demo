# frozen_string_literal: true

FactoryBot.define do
  factory :customer do
    first_name { Forgery(:name).first_name }
    last_name { Forgery(:name).last_name }
    phone { Forgery(:address).phone }
    birthday { 20.years.ago }
    id_number do
      s = ''
      10.times { s += Forgery(:basic).number.to_s }
      s
    end
    registration_phone_price { Money.new(Forgery('basic').number * 111, 'USD') }
  end
end
