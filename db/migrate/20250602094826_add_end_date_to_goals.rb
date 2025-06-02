class AddEndDateToGoals < ActiveRecord::Migration[7.2]
  def change
    add_column :goals, :end_date, :date
  end
end
