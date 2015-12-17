class CarsController < InheritedResources::Base

  private

    def car_params
      params.require(:car).permit(:year, :brand, :model)
    end
end

