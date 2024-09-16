# frozen_string_literal: true

FactoryBot.define do
  factory :phone do
    imei do
      s = ''
      10.times { s += Forgery(:basic).number.to_s }
      s
    end

    association :customer
  end
end
