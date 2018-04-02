class CreateDistances < ActiveRecord::Migration[5.1]
  def change
    create_table :distances do |t|
      t.string :origin
      t.string :destination
      t.integer :length

      t.timestamps
    end
    add_index :distances, :origin
    add_index :distances, :destination
  end
end
