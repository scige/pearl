class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.integer :category
      t.string :source
      t.datetime :begin_at
      t.datetime :end_at
      t.integer :status
      t.references :user

      t.timestamps
    end
    add_index :projects, :user_id
  end
end
