class AddIsLocalToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :is_local, :boolean
  end
end
