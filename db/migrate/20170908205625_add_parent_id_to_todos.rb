class AddParentIdToTodos < ActiveRecord::Migration[5.0]
  def change
    # add_reference :todos, :tododd
    add_column :todos, :parent_id, :integer
  end
end
