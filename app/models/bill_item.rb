class BillItem < ActiveRecord::Base
  belongs_to :bill
  belongs_to :bill_participant
  
  validates_presence_of :name
end
