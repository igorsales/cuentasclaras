class VisitorsController < ApplicationController
  def visitor_permalink
    @visitor = Visitor.find(:first, :conditions => { :permalink => params[:permalink] } )
	
	respond_to do |format| 
	  if @visitor.nil?
	    flash[:error] = t('msg.visitor_permalink_not_found')
	  else
	    session[:visitor_id] = @visitor.id
	  end
	  format.html { redirect_to bills_url }
	  format.xml  { }
	end
  end
  
  def set_locale
    @visitor = visitor
    @visitor.update_attributes(params[:visitor])
    
    respond_to do |format|
      format.html { redirect_to :back }
      format.xml  { head :ok }
    end
  end
end
