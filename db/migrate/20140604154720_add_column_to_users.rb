class AddColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :identity, :integer
    add_column :users, :phone, :string
  end
end
