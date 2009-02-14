class Visitor < ActiveRecord::Base
  has_and_belongs_to_many :bills, :join_table => :visitor_bills
end
