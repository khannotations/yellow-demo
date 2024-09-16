# frozen_string_literal: true

class CreatePhones < ActiveRecord::Migration[7.2]
  def change
    create_table :phones do |t|
      t.belongs_to :customer, null: false, foreign_key: true
      t.string :imei

      t.timestamps
    end
  end
end
