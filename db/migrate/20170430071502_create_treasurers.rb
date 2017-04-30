class CreateTreasurers < ActiveRecord::Migration[5.0]
  def change
    create_table :treasurers do |t|
      t.string :date, null: false
      t.string :price, null: false
      t.string :comment, null: false
      t.string :category, null: false
      t.references :user, null: false
      t.timestamps
    end
  end
end
