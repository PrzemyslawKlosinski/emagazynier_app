class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.boolean :is_income
      t.boolean :is_outcome
      t.boolean :is_correct
      t.integer :status
      t.string :name
      t.string :title
      t.datetime :document_date
      t.decimal :brutto_value
      t.decimal :netto_value
      t.decimal :brutto_netto
      t.text :description
      t.string :receipt
      t.datetime :receipt_date
      t.boolean :blocked
      t.references :document_correct
      t.references :last_correct
      t.references :user
      t.references :firm

      t.timestamps
    end
    add_index :documents, :document_correct_id
    add_index :documents, :last_correct_id
    add_index :documents, :user_id
    add_index :documents, :firm_id
  end
end
