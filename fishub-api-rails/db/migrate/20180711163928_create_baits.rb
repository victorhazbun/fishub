class CreateBaits < ActiveRecord::Migration[5.2]
  def change
    create_table :baits do |t|
      t.string :name
      t.string :category
      t.string :image

      t.timestamps
    end
    add_index :baits, :name, unique: true
  end
end
