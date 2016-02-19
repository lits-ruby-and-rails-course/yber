require 'rails_helper'

RSpec.describe Location do
  describe "instance creation" do 
    it 'should create instance of Location' do
      location = ::Location.new(23,34)
      expect(location.class).to eq Location
    end

    it 'should appropriate attributes' do
      location = ::Location.new(23, 34)
      expect(location).to have_attributes(latitude: 23, longitude: 34, title: "Qesm Shlatin, Red Sea Governorate, Egypt")
    end

    it 'should appropriate place attribute' do
      location = ::Location.new(23, 34)
      expect(location.place).to have_attributes(formatted_address: 'Qesm Shlatin, Red Sea Governorate, Egypt')
    end
  end

  describe ".marker_params" do
    it 'should return appropriate infowindow' do
      location = ::Location.new(23, 34)
      expect(location.marker_params).to eq({lat: 23, lng: 34, infowindow: "Qesm Shlatin, Red Sea Governorate, Egypt"})
    end

    it 'should return no inforwindow' do
      location = ::Location.new(-23, -34)
      expect(location.marker_params).to eq({lat: -23, lng: -34, infowindow: nil})
    end
  end

  describe ".map_params" do
    it 'should return appropriate map params' do
      location = ::Location.new(23, 34)
      expect(location.map_params).to eq({c_lat: 23, c_lng: 34, zoom: 15})
    end
  end
end