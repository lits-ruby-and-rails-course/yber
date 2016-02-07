# Reusable code for guest users
#

module VisitorsHelper
  def resource_name
    :user
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
