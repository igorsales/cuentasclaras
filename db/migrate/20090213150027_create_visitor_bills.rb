class CreateVisitorBills < ActiveRecord::Migration
  def self.up
    create_table :visitor_bills do |t|
      t.integer :bill_id

      t.timestamps
    end
  end

  def self.down
    drop_table :visitor_bills
  end
end
