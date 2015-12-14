class GmapsController < ApplicationController

	class Location
		attr_accessor :latitude, :longitude, :place, :title, :zoom
		def initialize(latitude, longitude)
      @latitude = latitude
      @longitude = longitude

      @place = Geocoder.search("#{latitude},#{longitude}").first
      if @place.present?
			  @title = @place.formatted_address
			end

      @zoom = 15
    end
	end

	def show_map
		# Change IP
		location_info = request.location #!!!
		l1 = Location.new(49.82, 24)

		# loc = Geocoder.coordinates "Lviv"
		# location_info.near([40.71, -100.23], 20, :units => :km)
		# @markers = Gmaps4rails.build_markers(location_info) do |location, marker|
		#   marker.lat l1.latitude
		#   marker.lng l1.longitude
		#   marker.infowindow l1.title
		# end

		@marker = { lat: l1.latitude, lng: l1.longitude, infowindow: l1.title }
		@opt = { c_lat: l1.latitude, c_lng: l1.longitude, zoom: l1.zoom }

	end

end
