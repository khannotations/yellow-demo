class AddPhoneToCustomer < ActiveRecord::Migration[7.2]
  def change
    add_column :customers, :phone, :string
  end
end
