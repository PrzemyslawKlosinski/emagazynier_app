class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :name
      t.text :about
      t.string :www
      t.boolean :isActive
      t.boolean :agreementElectronicInvoice
      t.boolean :agreementProcessing
      t.binary :headerPicture
      t.text :headerText
      t.text :footerText
      t.references :location
      t.boolean :partialInventory

      t.timestamps
    end
    add_index :users, :location_id
  end
end
