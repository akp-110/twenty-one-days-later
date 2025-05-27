class CreateGoals < ActiveRecord::Migration[7.2]
  def change
    create_table :goals do |t|
      t.string :name
      t.date :start_date
      t.text :reason
      t.references :user, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
