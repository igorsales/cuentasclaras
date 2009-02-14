class CreateBillPayments < ActiveRecord::Migration
  def self.up
    create_table :bill_payments do |t|
      t.integer :bill_item_id
      t.integer :bill_participant_id
      t.decimal :value

      t.timestamps
    end
  end

  def self.down
    drop_table :bill_payments
  end
end
