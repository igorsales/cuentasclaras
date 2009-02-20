class RemoveIdFromVisitorBills < ActiveRecord::Migration
  def self.up
    remove_column :visitor_bills, :id
  end

  def self.down
    add_column :visitor_bills, :id, :integer, { :primary_key => :id }
  end
end
