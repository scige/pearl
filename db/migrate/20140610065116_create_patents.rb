class CreatePatents < ActiveRecord::Migration
  def change
    create_table :patents do |t|
      t.string :title
      t.string :agency
      t.integer :status
      t.references :user

      t.timestamps
    end
    add_index :patents, :user_id
  end
end
