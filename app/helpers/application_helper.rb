# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def add_image_tag
    image_tag('add.png')
  end

  def edit_image_tag
    image_tag('edit.png')
  end

  def delete_image_tag
    image_tag('delete.png')
  end
  
  def link_image_tag
    image_tag('link.png')
  end
  
  def tut_image_tag(number)
    image_tag( I18n.locale + '/tut/tut' + number.to_s + '.png' )
  end

  def welcome_image_tag(number)
    image_tag( I18n.locale + '/welcome' + number.to_s + '.png' )
  end

  def visitor
    if session[:visitor_id]
      Visitor.find(session[:visitor_id])
    end
  end
  
  def locales_array
    [ 
      ['English',             'en'],
      ['Português do Brasil', 'pt-BR'], 
      ['Español',             'es']
    ]

  end
  
  def my_google_ad(format)
    if RAILS_ENV == 'production'
      google_ad(format)
    end
  end
end
