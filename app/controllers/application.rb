# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  before_filter :set_user_language
  before_filter :check_disclaimer_accept
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
  
  def set_user_language
    @visitor = visitor
    if @visitor.locale.nil?
      I18n.locale = 'en'
    else
      I18n.locale = @visitor.locale
    end
  end
  
  def currency_to_float(value)
    if /([0-9,\.]+)/.match(value)
      value = $1
    end
    
    separator = t('number.currency.format.separator')
    delimiter = t('number.currency.format.delimiter')
    
    delimiter = "\\." if delimiter == '.'
    separator = "\\." if separator == '.'

    value.gsub!(/#{delimiter}/,'')
    if separator != '.'
      value.gsub!(/#{separator}/,'.')
    end
    
    value.to_f
  end
  
  def check_disclaimer_accept
    @visitor = visitor
    if params[:controller] != 'visitors' and params[:action] != 'disclaimer' and
       !@visitor.accept_disclaimer

      session[:user_was_going_to] = request.request_uri
      if session[:user_was_going_to] == visitor_disclaimer_url(@visitor)
        session[:user_was_going_to] = bills_url
      end

      redirect_to visitor_disclaimer_url(@visitor)
    end
  end
end
