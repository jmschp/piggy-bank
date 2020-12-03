class AddTypeToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :task_type, :string, null: false
  end
end
