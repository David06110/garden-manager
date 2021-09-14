class AddUserRefToGardens < ActiveRecord::Migration[6.1]
  def change
    add_reference :gardens, :user, null: false, default: '1', foreign_key: true
  end
end
