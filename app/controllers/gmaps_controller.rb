class GmapsController < ApplicationController
  layout "rider_layout.html", only: [:rider_dashboard]

  def rider_dashboard
    # IP ::Location
    # ::Location_info = request.::Location 
    # l = ::Location.new(::Location_info.latitude, ::Location_info.longitude)
    l1 = ::Location.new(49.82, 24)

    @marker_options = l1.marker_params
    @map_options = l1.map_params
  end

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

end
