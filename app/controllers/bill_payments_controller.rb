class BillPaymentsController < ApplicationController
  def update
    @bill_item = BillItem.find(params[:bill_item_id])
	@bill_participant = BillParticipant.find(params[:bill_participant_id])
	@bill_payment = BillPayment.find(:first, :conditions => { :bill_item_id => @bill_item.id, :bill_participant_id => @bill_participant.id } )
	
	if @bill_payment
	  if 0 < params[:value].to_f
	    @bill_payment.update_attributes(:value => params[:value])
	  else
	    @bill_payment.destroy
	  end
	else # create a new one
	  @bill_payment = BillPayment.new( :value => params[:value] )
	  @bill_payment.bill_item = @bill_item
	  @bill_payment.bill_participant = @bill_participant
	  @bill_payment.save
	end
	
	respond_to do |format|
	  format.html { redirect_to bill_bill_items_url(@bill_item.bill) }
	  format.xml  { head :ok }
    end
  end

end
