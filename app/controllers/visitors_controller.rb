class VisitorsController < ApplicationController
  before_filter :check_disclaimer_accept, :except => 'set_locale'

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

  def disclaimer
    # TODO: Fix this into content
    #@disclaimer = File.read( "#{RAILS_ROOT}/public/disclaimer/disclaimer.#{I18n.locale}.txt" )

    respond_to do |format|
      format.html
    end
  end
  
  def accept_disclaimer
    if session[:visitor_id].nil?
      @visitor = Visitor.new
      @visitor.update_attributes(:accept_disclaimer => true)
      @visitor.save
      session[:visitor_id] = @visitor.id
    end

    if session[:user_was_going_to].nil?
      session[:user_was_going_to] = bills_url
    end

    respond_to do |format|
      format.html { redirect_to session[:user_was_going_to]; session[:user_was_going_to] = nil }
    end
  end
end
