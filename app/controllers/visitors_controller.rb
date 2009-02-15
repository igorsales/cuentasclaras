class VisitorsController < ApplicationController
  def visitor_permalink
    @visitor = Visitor.find(:first, :conditions => { :permalink => params[:permalink] } )
	
	respond_to do |format| 
	  if @visitor.nil?
	    flash[:error] = 'Cannot find permalink'
	  else
	    session[:visitor_id] = @visitor.id
	  end
	  format.html { redirect_to bills_url }
	  format.xml  { }
	end
  end
end
