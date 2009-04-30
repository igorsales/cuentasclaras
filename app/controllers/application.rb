# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  before_filter :set_user_language
  #before_filter :check_disclaimer_accept
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
    # Find the visitor from the session id
    if session[:visitor_id]
	  visitor = Visitor.find(session[:visitor_id])
    else
      # Well, no session, so did we store a proper visitor cookie?
      if cookies[:visitor_permalink]
        visitor = Visitor.find(:first, :conditions => { :permalink => cookies[:visitor_permalink] } )
        if visitor
          session[:visitor_id] = visitor.id
        end
      end      
	end
	
	visitor
  end
  
  def set_user_language
    @visitor = visitor
    if @visitor.nil? or @visitor.locale.nil?
      if session[:locale].nil?
        host = request.host
        if /\.(ar|es)$/.match(host) or /cuentasclaras\./.match(host)
          I18n.locale = 'es'
        elsif /\.(br)$/.match(host) or /contasclaras\./.match(host)
          I18n.locale = 'pt-BR'
        else
          I18n.locale = 'en'
        end
      else
        I18n.locale = session[:locale]
      end
    else
      I18n.locale = @visitor.locale
    end
  end

  def set_locale
    if /(pt-BR|e([ns]))/.match(params[:visitor][:locale])
      @visitor = visitor
      if @visitor
        @visitor.update_attributes(params[:visitor])
        session[:locale] = nil
      else
        session[:locale] = params[:visitor][:locale]
        I18n.locale = session[:locale]
      end
    end
    
    respond_to do |format|
      format.html { redirect_to :back }
      format.xml  { head :ok }
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
    if params[:controller] != 'visitors' and params[:action] != 'disclaimer'
      @visitor = visitor
      
      if @visitor.nil? or not @visitor.accept_disclaimer
        session[:user_was_going_to] = request.request_uri
        if session[:user_was_going_to] == visitor_disclaimer_url
          session[:user_was_going_to] = bills_url
        end

        flash[:notice] = t('msg.accept_disclaimer')
        redirect_to visitor_disclaimer_url
      end
    end
  end
  
  def logout
    session[:session_was_going_to] = nil
    session[:visitor_id]           = nil
    cookies[:visitor_permalink]    = nil
    
    respond_to do |format|
      format.html { redirect_to 'http://www.google.com' }
    end
  end
end
