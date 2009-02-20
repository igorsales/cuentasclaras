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
  
  def disclaimer
    @visitor = visitor
    
    @disclaimer = File.read( "#{RAILS_ROOT}/public/disclaimer/disclaimer.#{I18n.locale}.txt" )

    respond_to do |format|
      format.html
    end
  end
  
  def accept_disclaimer
    if visitor.update_attributes(:accept_disclaimer => true)
    
      if session[:user_was_going_to].nil?
        session[:user_was_going_to] = bills_url
      end

      respond_to do |format|
        format.html { redirect_to session[:user_was_going_to]; session[:user_was_going_to] = nil }
      end
    else
      respond_to do |format|
        format.html { redirect_to visitor_disclaimer_url(visitor) }
      end
    end
  end
end
