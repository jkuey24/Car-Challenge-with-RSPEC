class CarController < ApplicationController
  def new_car
    if !params.has_key?(:make)|| params[:make].strip.empty?
      render "new_car"
    else
      car = Car.new(params[:make], params[:model_year])
      session[:car]= car.to_yaml

      redirect_to "/simulator/do"
    end
  end
end
