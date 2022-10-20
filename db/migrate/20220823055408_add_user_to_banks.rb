class AddUserToBanks < ActiveRecord::Migration[7.0]
  def change
    add_reference :banks, :user, null: false, foreign_key: true
  end
end
