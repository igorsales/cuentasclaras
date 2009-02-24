class BillPaymentsController < ApplicationController
  def update
    @bill_item = BillItem.find(params[:bill_item_id])
	@bill_participant = BillParticipant.find(params[:bill_participant_id])
	@bill_payment = BillPayment.find(:first, :conditions => { :bill_item_id => @bill_item.id, :bill_participant_id => @bill_participant.id } )

    value  = currency_to_float( params[:value] )
    exempt = ( "1" == params[:exempt] )
	
	if @bill_payment
	  if exempt or value > 0
	    @bill_payment.update_attributes(:value => value, :exempt => exempt)
	  else
	    @bill_payment.destroy
	  end
	else # create a new one
	  @bill_payment = BillPayment.new( :value => value, :exempt => exempt )
	  @bill_payment.bill_item = @bill_item
	  @bill_payment.bill_participant = @bill_participant
	  @bill_payment.save
	end

    @bill = @bill_item.bill
    @bill_participants = @bill.bill_participants    
	
	respond_to do |format|
	  format.html { redirect_to bill_bill_items_url(@bill_item.bill) }
      format.js
	  #format.xml  { head :ok }
    end
  end

end
