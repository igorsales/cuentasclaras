class Bill < ActiveRecord::Base
  belongs_to    :visitor_bill
  has_many      :bill_participants
  has_many      :bill_items
  has_permalink :name
  has_and_belongs_to_many :visitors, :join_table => :visitor_bills
  
  validates_presence_of :name
  
  def total_paid_by_bill_participant(participant)
    BillPayment.sum( :value, :conditions => 
	  { :bill_participant_id => participant.id, :bill_item_id => bill_items } )
  end
  
  def who_owes_who_initial_matrix
    matrix = {}
	paid_per_participant = Array.new
    people_cnt = bill_participants.sum(:party_size)
	
	bill_participants.each do |q|
	  owed_per_participant = total_paid_by_bill_participant(q) / people_cnt
	  paid_per_participant << { :value => owed_per_participant, :obj => q }

	  # Fill in the matrix
	  bill_participants.each do |p|
	    if !matrix[ p.id ]
		  matrix[ p.id ] = {}
		end
		
	    if p != q 
	      matrix[ p.id ][ q.id ] = owed_per_participant * p.party_size;
		else
		  matrix[ p.id ][ q.id ] = 0.0
		end
	  end
	end
	
	sorted_bill_participants = paid_per_participant.sort { |a,b| a[:value] <=> b[:value] }
	
	@sorted_bill_participants = []
	sorted_bill_participants.each do |e|
	  @sorted_bill_participants << e[ :obj ]
	end
	
	return matrix
  end
  
  def who_owes_who
    matrix = who_owes_who_initial_matrix
	
	@sorted_bill_participants.each do |a|
	  @sorted_bill_participants.each do |b|
	    if a != b
		  # if B owes A more than A owes B, and 
		  if matrix[ b.id ][ a.id ] >= matrix[ a.id ][ b.id ]
			matrix[ b.id ][ a.id ] -= matrix[ a.id ][ b.id ]
			matrix[ a.id ][ b.id ]  = 0
		  end
		end
	  end
	end
	
	# Simplify matrix
	@sorted_bill_participants.each do |a|
	  @sorted_bill_participants.each do |b|
	    @sorted_bill_participants.each do |c|
		  # If A owes B, B owes C, and A owes C, then 
		  if matrix[ a.id ][ b.id ] > 0 and matrix[ b.id ][ c.id ] > 0 and matrix[ a.id ][ c.id ] > 0
	
		    # Calculate the minimum between the three, and transfer it.	  
			diff = [ matrix[ a.id ][ b.id ], matrix[ a.id ][ c.id ], matrix[ b.id ][ c.id ] ].min
			
			matrix[ a.id ][ b.id ] -= diff
			matrix[ b.id ][ c.id ] -= diff
			matrix[ a.id ][ c.id ] += diff
		  end
	    end
	  end
	end
	
	matrix
  end
end
