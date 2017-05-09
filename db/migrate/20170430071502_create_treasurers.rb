class CreateTreasurers < ActiveRecord::Migration[5.0]
  def change
    create_table :treasurers do |t|
      t.date :date, null: false
      t.integer :price, null: false
      t.string :comment, null: false
      t.string :category, null: false
      t.references :user, null: false
      t.timestamps
    end
  end
end
