class GmapsController < ApplicationController

	class Location
		attr_accessor :latitude, :longitude, :place, :title, :zoom
		def initialize(lat, lng)
      @latitude = lat
      @longitude = lng
      @place = Geocoder.search("#{lat},#{lng}").first
      if @place.present?
			  @title = @place.formatted_address
			end
			#first init
			@@center_latitude ||= @latitude
			@@center_longitude ||= @longitude
      @zoom ||= 15
    end
    def marker_params
    	hash = {
    		lat: @latitude,
    		lng: @longitude,
    		infowindow: @title
    	}
    end
    def map_params
    	hash = {
    		c_lat: @@center_latitude,
    		c_lng: @@center_longitude,
    		zoom: @zoom
    	}
    end
	end

	def dashboard
		# Change IP
		# location_info = request.location 
	  # l = Location.new(location_info.latitude, location_info.longitude)
		l1 = Location.new(49.82, 24)

		@marker_options = l1.marker_params
		@map_options = l1.map_params
	end

	def take_position
		# Change IP
		# location_info = request.location 
	  # l = Location.new(location_info.latitude, location_info.longitude)
	  l1 = Location.new(49.82, 24)
	  
		render json: { marker_options: l.marker_params, map_options: l.map_params }
	end

	def find_place
		place = Geocoder.search("#{params[:lat]},#{params[:lng]}").first
    if place.present?
    	render json: { place: place.formatted_address }
    else
		  redirect_to :back, alert: "ERROR: "
		end
	end

end
