class CreateGroups < ActiveRecord::Migration[7.2]
  def change
    create_table :groups do |t|
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
