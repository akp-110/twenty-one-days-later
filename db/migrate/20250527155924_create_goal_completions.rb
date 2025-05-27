class CreateGoalCompletions < ActiveRecord::Migration[7.2]
  def change
    create_table :goal_completions do |t|
      t.date :date
      t.references :user, null: false, foreign_key: true
      t.references :goal, null: false, foreign_key: true

      t.timestamps
    end
  end
end
