class AddDefaultValueToUsers < ActiveRecord::Migration
  def self.up
     change_column :users, :isActive, :boolean, :default => false, :null => false
  end
end
