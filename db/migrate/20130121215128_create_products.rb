class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.decimal :summaryQuantityPurchase
      t.decimal :summaryQuantitySales
      t.string :nameOryginal
      t.string :name
      t.decimal :quantity
      t.decimal :reservedQuantity
      t.decimal :quantityMinimum
      t.decimal :quantityMaximum
      t.text :warningNote
      t.boolean :isWarningShow
      t.text :description
      t.binary :picture
      t.boolean :blocked
      t.references :user
      t.references :category
      t.references :productPrice
      t.decimal :defaultIncrease
      t.decimal :defaultDecrease
      t.decimal :defaultVat
      t.boolean :actualPriceOnPurchase
      t.string :manufacturer
      t.string :color
      t.string :intended
      t.string :location
      t.string :size
      t.string :shape
      t.text :descriptions
      t.references :unit

      t.timestamps
    end
    add_index :products, :user_id
    add_index :products, :category_id
    add_index :products, :productPrice_id
    add_index :products, :unit_id

    add_index :products, [:user_id, :created_at]
  end
end
