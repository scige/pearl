class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :title
      t.text :content
      t.references :user
      t.references :project

      t.timestamps
    end
    add_index :documents, :user_id
    add_index :documents, :project_id
  end
end
