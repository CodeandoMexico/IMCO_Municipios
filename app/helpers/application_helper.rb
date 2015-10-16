module ApplicationHelper
  def user_is_admin?
    user_signed_in? && current_user.admin?
  end

  def navbar_title(city)
    title = "Mi Negocio México"
    if city
      title + " | #{city}"
    else
      title
    end
  end

  def page_title(base_title="Mi Negocio México", subtitle=nil)
    if subtitle.nil?
      content_tag :title, base_title
    else
      content_tag :title, "#{base_title} | #{subtitle}"
    end
  end


  def ordenate_date(date)
    fecha = date.split('/')
    if fecha.length == 3
      return (fecha[1]+"/"+fecha[0]+"/"+fecha[2]).to_date 
    elsif fecha.length == 1
          fecha = date.split('-')
        if fecha.length == 3
          return (fecha[2]+"-"+fecha[1]+"-"+fecha[0]).to_date 
      end
    end
end

end
