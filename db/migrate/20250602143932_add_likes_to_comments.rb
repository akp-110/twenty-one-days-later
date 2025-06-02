class AddLikesToComments < ActiveRecord::Migration[7.2]
  def change
    add_column :comments, :likes, :integer, null: false, default: 0
  end
end
