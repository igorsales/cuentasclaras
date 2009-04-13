class BillParticipantsController < ApplicationController
  def new
    @bill = Bill.find(params[:bill_id])
    @bill_participant = BillParticipant.new
	
	respond_to do |format|
	  format.html # new.html.erb
	  format.xml  { render :xml => @bill_participant } 
	end
  end
  
  def create
    @bill_participant = BillParticipant.new(params[:bill_participant])
	@bill_participant.bill = Bill.find(params[:bill_id])
	
	if @bill_participant.save
	  respond_to do |format|
		format.html { redirect_to( bill_bill_items_url(@bill_participant.bill) ) }
	    format.xml  { render :xml => @bill_participant }
	  end
	else
	end
  end

  def destroy
    @bill_participant = BillParticipant.find(params[:id])
	@bill = @bill_participant.bill
    @bill_participant.bill_payments.each { |p| p.destroy }
	@bill_participant.destroy

    respond_to do |format|
      format.html { redirect_to( bill_bill_items_url(@bill) ) }
	  format.xml  { head :ok }
	end
  end

  def edit
    @bill_participant = BillParticipant.find(params[:id])
	@bill = @bill_participant.bill
  end

  def update
    @bill_participant = BillParticipant.find(params[:id])
	@bill = @bill_participant.bill

    respond_to do |format|
      if @bill_participant.update_attributes(params[:bill_participant])
        flash[:notice] = t('msg.bill_participant_update_ok')
		
	    format.html { redirect_to( bill_bill_items_url(@bill) ) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @bill_participant.errors, :status => :unprocessable_entity }
      end
    end
  end

end
