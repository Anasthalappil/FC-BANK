class CreateHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :histories do |t|
      t.integer :user_id
      t.decimal :acc_number
      t.decimal :amount
      t.decimal :tans_no
      t.string :trans_to
      t.string :type

      t.timestamps
    end
  end
end
