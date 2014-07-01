class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :content
      t.references :document
      t.references :user

      t.timestamps
    end
    add_index :reviews, :document_id
    add_index :reviews, :user_id
  end
end
