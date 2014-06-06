class AddDateToDailies < ActiveRecord::Migration
  def change
    add_column :dailies, :date, :datetime
  end
end
