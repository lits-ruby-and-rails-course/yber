module ReviewsHelper
  def edit_accessible?
    current_user.admin? || (current_user.rider? && @order.rider_id == current_user.id)
  end
end
