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
    {
      lat: @latitude,
      lng: @longitude,
      infowindow: @title
    }
  end

  def map_params
    {
      c_lat: @@center_latitude,
      c_lng: @@center_longitude,
      zoom: @zoom
    }
  end
end