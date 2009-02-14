class BillItemsController < ApplicationController
  def index
    @bill = Bill.find(params[:bill_id])
	@bill_items = @bill.bill_items.find(:all, :order => :date)
	@bill_participants = @bill.bill_participants.find(:all)
	
	# Determine if this bill already belongs to this visitor
	@should_ask_to_add_bill_to_current_visitors_list = visitor.bills.find(:first, :conditions => {:id => @bill.id}).nil?
	
	respond_to do |format|
	  format.html # index.html.erb
	  format.xml { render :xml => @bill_items }
	end
  end
  
  def new
    @bill = Bill.find(params[:bill_id])
	
	@bill_item = BillItem.new(:date => Time.zone.today, :name => 'New item')
	@bill_item.bill = @bill

	if @bill_item.save
	  respond_to do |format|
	    format.html { redirect_to bill_bill_items_url(@bill) }
		format.xml  { render :xml => @bill_item }
	  end
	end
  end
  
  def update
    @bill_item = BillItem.find(params[:id])
	@bill = @bill_item.bill

    respond_to do |format|
      if @bill_item.update_attributes(params[:bill_item])
		format.html { redirect_to( bill_bill_items_url(@bill) ) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @menu_item.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @bill_item = BillItem.find(params[:id])
	@bill = @bill_item.bill
	
	@bill_item.destroy
	
	respond_to do |format|
	  format.html { redirect_to( bill_bill_items_url(@bill) ) }
	  format.xml  { head :ok }
	end
  end
end
