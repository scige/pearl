class AddColumnToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :category,  :integer
    add_column :documents, :paper_id,  :integer
    add_column :documents, :patent_id, :integer
  end
end
