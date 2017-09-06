class CreateTodos < ActiveRecord::Migration[5.0]
  def change
    create_table :todos do |t|
      t.string :task
      t.date :deadline
      t.boolean :completed
      t.text :details

      t.timestamps
    end
  end
end
