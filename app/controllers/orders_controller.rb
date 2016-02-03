class OrdersController < ApplicationController
  before_action :set_order, only: [:destroy]
  before_filter :authenticate_user!
  layout "dashboard.html", only: [:show, :new, :index]

  def index
    @orders = case current_user.role
    when "rider"
      Order.where(rider_id: current_user.id);
    when "driver"
      Order.where("status = ? or driver_id = ?", status[0], current_user.id)
    else #admin -> all, for debugging
      Order.all
    end
  end

  def show
    order = Order.find(params[:id])
    if (current_user.role == 'admin') || ((current_user == 'rider') && (order.rider_id == current_user.id)) || ((current_user.role == 'driver') && ((order.driver_id == current_user.id) || (order.status == 'pending')))
      @order = order
    else
      redirect_to :trips, alert: 'Sorry but you have not access!'
    end
  end

  def new
    # if current_user.role == 'admin' || current_user.role == 'rider'
      @order = Order.new
      # IP ::Location
      # ::Location_info = request.::Location 
      # l = ::Location.new(::Location_info.latitude, ::Location_info.longitude)
      l1 = ::Location.new(49.82, 24)

      @marker_options = l1.marker_params
      @map_options = l1.map_params
    # end
  end

  def create
    @order = Order.new(order_params)
    status = @order.save ? 200 : 422
    render template: 'orders/show.json', status: status
  end

  def destroy
    if (current_user.role == 'admin') || ((current_user.role == 'rider') && (@order.rider_id == current_user.id) && (@order.status == "pending"))
      @order.destroy
      respond_to do |format|
        format.html { redirect_to :trips, notice: 'Order was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to :trips, alert: 'Sorry but you have not access!'
    end
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
      params.require(:order).permit(:rider_id, :location_to, :location_from, :status, :description, :pessengers, :mfrom_lat, :mfrom_lng, :mto_lat, :mto_lng, :price) 
    end
end
