module DashboardHelper
  def find_current_order
    if current_user.role == 'rider'
      order = Order.where(rider_id: current_user.id).last
    elsif current_user.role == 'driver'
      order = Order.where(driver_id: current_user.id).sort_by(&:updated_at).last
    else #admin
      return nil
    end
    if (order != nil) && (order.status != "completed")
      order
    else
      nil
    end
  end
end
