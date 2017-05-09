class CreateTreasurers < ActiveRecord::Migration[5.0]
  def change
    create_table :treasurers do |t|
      t.date :date, null: false
      t.integer :price, null: false
      t.string :comment, limit: 20
      t.string :category, limit: 20
      t.references :user, null: false
      t.timestamps
    end
  end
end
