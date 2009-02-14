class BillPayment < ActiveRecord::Base
  belongs_to :bill_item
  belongs_to :bill_participant

  validates_numericality_of :value, :greater_than => 0
end
