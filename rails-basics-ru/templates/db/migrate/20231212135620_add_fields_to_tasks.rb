class AddFieldsToTasks < ActiveRecord::Migration[7.1]
  def change
    add_column :tasks, :name, :string
    add_column :tasks, :description, :text
    add_column :tasks, :status, :string
    add_column :tasks, :creator, :string
    add_column :tasks, :performer, :string
    add_column :tasks, :completed, :boolean
  end
end
