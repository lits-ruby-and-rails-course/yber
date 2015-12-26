# Reusable code to define a guest
#

class VisitorsController < ApplicationController
  def index
    @guest = User.new
    @guest.build_profile
  end
end
