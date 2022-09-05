class CreateTackleBoxItems < ActiveRecord::Migration[5.2]
  def change
    create_table :tackle_box_items do |t|
      t.references :bait, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
