class VisitorsController < ApplicationController

  def index
    @guest = User.new
    @guest.build_profile
  end
end
