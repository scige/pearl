class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :title
      t.text :note
      t.datetime :begin_at
      t.datetime :end_at
      t.integer :status
      t.references :user

      t.timestamps
    end
    add_index :plans, :user_id
  end
end
