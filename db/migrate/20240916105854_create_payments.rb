# frozen_string_literal: true

class CreatePayments < ActiveRecord::Migration[7.2]
  def change
    create_table :payments do |t|
      t.belongs_to :customer, null: false, foreign_key: true

      t.monetize :amount
      t.string :status, default: 'pending', null: false
      t.string :phone
      t.string :telco

      t.timestamps
    end
  end
end
