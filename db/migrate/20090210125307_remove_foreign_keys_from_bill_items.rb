class RemoveForeignKeysFromBillItems < ActiveRecord::Migration
  def self.up
    remove_column :bill_items, :value
    remove_column :bill_items, :paid_by 
  end

  def self.down
    add_column :bill_items, :value, :decimal, :precision => 2
    add_column :bill_items, :paid_by, :integer
  end
end
