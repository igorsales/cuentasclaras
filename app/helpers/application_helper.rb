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
  
  def visitor
    Visitor.find(session[:visitor_id])
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
