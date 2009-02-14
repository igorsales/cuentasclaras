class AddVisitorIdToVisitorBills < ActiveRecord::Migration
  def self.up
    add_column :visitor_bills, :visitor_id, :integer
  end

  def self.down
    remove_column :visitor_bills, :visitor_id
  end
end
