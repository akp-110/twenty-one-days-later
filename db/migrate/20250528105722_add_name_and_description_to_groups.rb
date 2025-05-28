class AddNameAndDescriptionToGroups < ActiveRecord::Migration[7.2]
  def change
    add_column :groups, :name, :string
  end
end
