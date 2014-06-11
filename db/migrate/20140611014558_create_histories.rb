class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.integer :category
      t.integer :detail_id
      t.integer :action
      t.references :user
      t.references :group

      t.timestamps
    end
    add_index :histories, :user_id
  end
end
