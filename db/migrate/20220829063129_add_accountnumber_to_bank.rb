class AddAccountnumberToBank < ActiveRecord::Migration[7.0]
  def change
    add_column :banks, :acc_number, :decimal
    add_column :banks, :acc_type, :string
  end
end
