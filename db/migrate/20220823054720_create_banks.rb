class CreateBanks < ActiveRecord::Migration[7.0]
  def change
    create_table :banks do |t|
      t.belongs_to :user, index: { unique: true }, foreign_key: true
      t.string :Name
      t.string :Place
      t.decimal :balance

      t.timestamps
    end
  end
end
