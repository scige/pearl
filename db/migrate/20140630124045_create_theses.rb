class CreateTheses < ActiveRecord::Migration
  def change
    create_table :theses do |t|
      t.string :title
      t.text :abstract
      t.string :keywords
      t.integer :status
      t.references :user

      t.timestamps
    end
    add_index :theses, :user_id

    add_column :documents, :thesis_id,  :integer
  end
end
