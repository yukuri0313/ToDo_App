class RemoveTodoIdFromCategories < ActiveRecord::Migration[6.1]
  def change
    remove_column :categories, :todo_id, :integer
  end
end
