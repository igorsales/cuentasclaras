class CreateBillItems < ActiveRecord::Migration
  def self.up
    create_table :bill_items do |t|
      t.string  :name
      t.date    :date
      t.decimal :value, :precision => 2
	  
	  # Foreign keys
	  t.integer :bill_id
	  t.integer :paid_by

      t.timestamps
    end
  end

  def self.down
    drop_table :bill_items
  end
end
