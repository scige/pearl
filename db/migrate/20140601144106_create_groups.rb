class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.string :university
      t.string :school

      t.timestamps
    end
  end
end
