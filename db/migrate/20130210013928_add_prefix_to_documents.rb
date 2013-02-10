class AddPrefixToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :prefix, :string
  end
end
