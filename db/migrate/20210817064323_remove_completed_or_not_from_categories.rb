class RemoveCompletedOrNotFromCategories < ActiveRecord::Migration[6.1]
  def change
    remove_column :todos, :completed_or_not, :integer
  end
end
