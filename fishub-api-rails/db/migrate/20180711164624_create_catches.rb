class CreateCatches < ActiveRecord::Migration[5.2]
  def change
    create_table :catches do |t|
      t.string :species
      t.decimal :weight
      t.decimal :length
      t.references :bait, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
