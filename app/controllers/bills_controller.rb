class BillsController < ApplicationController
  before_filter :check_disclaimer_accept

  def index
    # First time this visitor shows up
    @bills = visitor.bills
	
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @bills }
    end
  end
  
  def show
    @bill = Bill.find(params[:id])
	
	respond_to do |format|
	  format.html { redirect_to(bill_bill_items_url(@bill) ) }
	  format.xml  { render :xml => @bill }	  
	end
  end
  
  def create
	@bill = Bill.new(params[:bill])
	visitor.bills << @bill
	
	if @bill.save
	  respond_to do |format|
        format.html { redirect_to(bill_bill_items_url(@bill) ) }
	    format.xml  { render :xml => @bill }
      end
	else
	  flash[:error] = t('msg.bill_add_failed')
        format.html { redirect_to(bill_bill_items_url(@bill) ) }
	    format.xml  { render :xml => @bill.errors, :status => :unprocessable_entity }
	end
  end

  def edit
    @bill = Bill.find(params[:id])
  end

  def update
    @bill = Bill.find(params[:id])

    respond_to do |format|
      if @bill.update_attributes(params[:bill])
        flash[:notice] = t('msg.bill_update_ok')
		
	    format.html { redirect_to( bills_url ) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @bill.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @bill = Bill.find(params[:id])	
	@bill.destroy
	
	respond_to do |format|
	  format.html { redirect_to( bills_url ) }
	  format.xml  { head :ok }
	end
  end
  
  def permalink
    @bill = Bill.find_by_permalink(params[:permalink])
 
    respond_to do |format|
      if @bill
        format.html { redirect_to bill_bill_items_url(@bill) }
        format.xml  { render :xml => @bill.to_xml }
	  else
	    flash[:notice] = t('msg.bill_permalink_not_found')
	    format.html { redirect_to bills_url }
		format.xml  { render :status => :unprocessable_entity } 
	  end
    end
  end
  
  def add_visitor
    @bill = Bill.find(params[:bill_id])
    visitor.bills << @bill
	
    respond_to do |format|
	  flash[:notice] = t('msg.bill_add_to_visitor_ok')
	  format.html { redirect_to bill_bill_items_url(@bill) }
	  format.xml  { head :ok }
	end
  end
end
