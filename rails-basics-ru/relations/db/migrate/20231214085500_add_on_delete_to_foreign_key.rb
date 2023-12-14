class AddOnDeleteToForeignKey < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :tasks, :statuses
    add_foreign_key :tasks, :statuses, on_delete: :nullify
    remove_foreign_key :tasks, :users
    add_foreign_key :tasks, :users, on_delete: :nullify
  end
end
