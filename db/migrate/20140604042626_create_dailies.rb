class CreateDailies < ActiveRecord::Migration
  def change
    create_table :dailies do |t|
      t.text :content
      t.references :user

      t.timestamps
    end
    add_index :dailies, :user_id
  end
end
