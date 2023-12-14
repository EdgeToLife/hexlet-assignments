class ChangeStatusNullInTasks < ActiveRecord::Migration[7.1]
  def change
    change_column_null :tasks, :status_id, true
  end
end
