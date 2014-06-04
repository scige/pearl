class CreatePapers < ActiveRecord::Migration
  def change
    create_table :papers do |t|
      t.string :title
      t.string :magazine
      t.integer :status
      t.references :user

      t.timestamps
    end
    add_index :papers, :user_id
  end
end
