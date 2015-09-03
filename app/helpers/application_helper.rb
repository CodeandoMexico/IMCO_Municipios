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

  def current_bussines
    Business.where(user_id: current_user, using: true)
  end
end
