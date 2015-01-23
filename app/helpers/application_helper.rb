module ApplicationHelper
  def user_is_admin?
    user_signed_in? && current_user.admin?
  end

  def navbar_title(city)
    title = "MiNegocio"
    if city
      title + " | #{city}"
    else
      title
    end
  end
end
