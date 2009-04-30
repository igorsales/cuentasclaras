class ContentController < ApplicationController
  def show
    render :action => I18n.locale + '/' + params[:path].join('/')
  end
  
  def welcome
    respond_to do |format|
      format.html # welcome.html.erb
    end
  end
end
