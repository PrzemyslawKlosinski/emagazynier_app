class CreateQuantities < ActiveRecord::Migration
  def change
    create_table :quantities do |t|
      t.decimal :amount
      t.decimal :netto_price
      t.decimal :brutto_price
      t.references :product
      t.references :document

      t.timestamps
    end
    add_index :quantities, :product_id
    add_index :quantities, :document_id
  end
end
