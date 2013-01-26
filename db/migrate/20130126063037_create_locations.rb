class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :zip_code
      t.string :city
      t.string :address
      t.string :phone
      t.references :firm

      t.timestamps
    end
    add_index :locations, :firm_id
  end
end
