class AddExemptToBillPayment < ActiveRecord::Migration
  def self.up
    add_column :bill_payments, :exempt, :boolean
  end

  def self.down
    remove_column :bill_payments, :exempt
  end
end
