class CreateTodos < ActiveRecord::Migration[6.1]
  def change
    create_table :todos do |t|
      t.string :title
      t.text :content
      t.datetime :deadline

      t.timestamps
    end
  end
end
