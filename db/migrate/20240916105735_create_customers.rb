# frozen_string_literal: true

class CreateCustomers < ActiveRecord::Migration[7.2]
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.string :id_number
      t.date :birthday
      t.datetime :approved_at
      t.monetize :registration_phone_price

      t.timestamps
    end
  end
end
