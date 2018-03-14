class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :asin, null: false
      t.text :category
      t.bigint :rank
      t.decimal :item_width
      t.decimal :item_height
      t.decimal :item_length
      t.text :item_width_units
      t.text :item_height_units
      t.text :item_length_units
      t.decimal :package_width
      t.decimal :package_height
      t.decimal :package_length
      t.text :package_width_units
      t.text :package_height_units
      t.text :package_length_units

      t.timestamps
    end
    add_index :products, :asin, unique: true
  end
end
