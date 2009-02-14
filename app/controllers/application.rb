# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'bb90e0b73422ccb132062d3cbe6ff141'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  layout 'main'
  
  def visitor
    if session[:visitor_id].nil?
	  @visitor = Visitor.new
	  @visitor.save
	  session[:visitor_id] = @visitor.id
	else
	  @visitor = Visitor.find(session[:visitor_id])
	  if @visitor.nil?
	    @visitor = Visitor.new
	    @visitor.save
  	    session[:visitor_id] = @visitor.id
	  end
	end
	
	@visitor
  end
end
