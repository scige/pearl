class AddNestedSetToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :parent_id, :integer
    add_column :groups, :lft, :integer
    add_column :groups, :rgt, :integer
    add_column :groups, :depth, :integer
  end
end
