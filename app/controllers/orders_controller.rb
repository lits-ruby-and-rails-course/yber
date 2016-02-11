class OrdersController < ApplicationController
  before_action :set_order, only: [:destroy, :driver_take_order, :complete_order]
  before_filter :authenticate_user!
  layout "dashboard.html", only: [:home, :show, :new, :index]

  def home
    case current_user.role
    when 'rider'
      order = Order.where(rider_id: current_user.id).last
      if (order == nil) || (order.status == 'completed')
        redirect_to :new_trip
      else
        redirect_to trip_path(order)
      end
    when "driver"
      order = Order.where(driver_id: current_user.id).sort_by(&:updated_at).last
      if (order != nil) && (order.status == 'accepted')
        redirect_to  trip_path(order)
      else
        redirect_to :trips, alert: "You haven't any orders in progress."
      end
    else
      redirect_to :trips
    end
  end

  def index
    @orders = case current_user.role
    when 'rider'
      Order.where(rider_id: current_user.id);
    when 'driver'
      Order.where("status = ? or driver_id = ?", status[0], current_user.id)
    else #admin -> all, for debugging
      Order.all
    end
  end

  def show
    order = Order.find(params[:id])
    if current_user.rider? && order.accepted?
      @review = Review.new
      @profile = Profile.find_by(user_id: order.driver_id)
    end

    if (current_user.role == 'admin') || ((current_user.role == 'rider') &&
       (order.rider_id == current_user.id)) || ((current_user.role == 'driver') &&
       ((order.driver_id == current_user.id) || (order.status == 'pending')))
      @order = order
    else
      redirect_to :dashboard, alert: 'Sorry but you have not access!'
    end
  end

  def new
    if current_user.role != 'rider'
      redirect_to :root #maybe should redirect to another place??
    end
    order = Order.where(rider_id: current_user.id).last
    if (order == nil) || (order.status == 'completed')
      @order = Order.new
      # IP ::Location
      # ::Location_info = request.::Location
      # l = ::Location.new(::Location_info.latitude, ::Location_info.longitude)
      l1 = ::Location.new(49.82, 24)

      @marker_options = l1.marker_params
      @map_options = l1.map_params
    else
      redirect_to  trip_path(order)
    end
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      redirect_to :back, notice: "Order was created successfully"
    else
      redirect_to :back, alert: "ERROR: For some reason order wasn't created"
    end
    # status = @order.save ? 200 : 422
    # render template: 'orders/show.json', status: status
  end

  def destroy
    if (current_user.role == 'admin') || ((current_user.role == 'rider') && (@order.rider_id == current_user.id) && (@order.status == "pending"))
      @order.destroy
      respond_to do |format|
        format.json { head :no_content }
        format.html { redirect_to :trips, notice: 'Order was successfully destroyed.' }
      end
    else
      redirect_to :dashboard, alert: 'Sorry but you have not access!'
    end
  end

  def driver_take_order
    @order.accepted!
    if @order.update_attribute(:driver_id, current_user.id)
      render json: { name: current_user.name, email: current_user.email,
                     phone: current_user.profile.phone, license_plate: current_user.profile.car_phone,
                     date: @order.updated_at.strftime('%c') }
    else
      redirect_to :back, alert: "ERROR: Order wasn't taked"
    end
  end

  def complete_order
    @order.completed!
    StatusMailer.completed_status_email(current_user).deliver_later
    render json: { notice: "Order was completed successfully", date: @order.updated_at.strftime('%c') }
  end

  # GOOGLE MAP AJAX
  def take_position
    # IP ::Location
    # ::Location_info = request.::Location
    # l = ::Location.new(::Location_info.latitude, ::Location_info.longitude)
    l = ::Location.new(49.82, 24)

    render json: { marker_options: l.marker_params, map_options: l.map_params }
  end

  def find_coords
    place = Geocoder.coordinates("#{params[:place]}")
    if place.present?
      l = ::Location.new(place[0],place[1])
      render json: { marker_options: l.marker_params }
    else
      redirect_to :back, alert: "ERROR: Can't find this place coordinates"
    end
  end

  def find_place
    place = Geocoder.search("#{params[:lat]},#{params[:lng]}").first
    if place.present?
      render json: { place: place.formatted_address }
    else
      redirect_to :back, alert: "ERROR: This coords are wrong"
    end
  end

  private
    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:rider_id, :location_to, :location_from,
                                     :status, :description, :pessengers,
                                     :mfrom_lat, :mfrom_lng, :mto_lat,
                                     :mto_lng, :price)
    end
end
