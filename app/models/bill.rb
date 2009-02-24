class Bill < ActiveRecord::Base
  belongs_to    :visitor_bill
  has_many      :bill_participants
  has_many      :bill_items
  has_permalink :name
  has_and_belongs_to_many :visitors, :join_table => :visitor_bills
  
  validates_presence_of :name
  
  def total_paid_by_bill_participant(participant)
    #BillPayment.sum( :value, :conditions => 
  	#  { :bill_participant_id => participant.id, :bill_item_id => bill_items } )
    participant.bill_payments.sum( :value )
  end
  
  def who_owes_who_initial_matrix
    matrix               = {}
    paid_per_participant = []

    # Initialize the matrix
    bill_participants.each do |p|
	  paid_per_participant << { :value => p.bill_payments.sum(:value), :obj => p }
      matrix[ p.id ] = {}
      bill_participants.each do |q|
        matrix[ p.id ][ q.id ] = 0.0
	  end
    end

    nbr_participants = bill_participants.sum( :party_size )
    bill_items.each do |item|
      # who are exempt of paying this item?
      exempt     = []
      nbr_exempt = 0
      item.bill_payments.each do |payment|
        if payment.exempt
          exempt << payment.bill_participant
          nbr_exempt += payment.bill_participant.party_size
        end
      end
      
      # If all are exempt, move on to next bill item. (Nobody pays anything)
      if nbr_exempt < nbr_participants
        nbr_payers  = nbr_participants - nbr_exempt
        
        # For each payment on this item
        item.bill_payments.each do |payment|
          per_payer = payment.value / nbr_payers
          payee     = payment.bill_participant
          
          # For each participant
          bill_participants.each do |payer|
            if payer != payee and not exempt.include?(payer)
              # Payer owes payee
              matrix[ payer.id ][ payee.id ] += per_payer
            end
          end
        end
      end
    end
	
	paid_per_participant = paid_per_participant.sort { |a,b| a[:value] <=> b[:value] }
	
	@sorted_bill_participants = []
	paid_per_participant.each do |e|
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
