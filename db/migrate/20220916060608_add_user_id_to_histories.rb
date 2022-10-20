class AddUserIdToHistories < ActiveRecord::Migration[7.0]
  def change
    add_column :histories, :user_id, :integer
  end
end
