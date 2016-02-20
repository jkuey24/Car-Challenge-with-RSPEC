class SimulatorController < ApplicationController
  def do
    @car = YAML.load(session[:car])

  end

  def lights_do
    @car = YAML.load(session[:car])

    if params[:lights] == "Lights On"
      @car.lights_on
    else
      @car.lights_off
    end

    session[:car] = @car.to_yaml
    redirect_to "/simulator/do"
    #render "do.html.erb"
  end

  def accelerate
    @car = YAML.load(session[:car])

    @car.accelerate
    session[:car] = @car.to_yaml
    redirect_to "/simulator/do"

  end

  def decelerate
    @car = YAML.load(session[:car])

    @car.decelerate
    session[:car] = @car.to_yaml
    redirect_to "/simulator/do"
  end

  def parking_do
    @car = YAML.load(session[:car])

    if params[:parking] == "Parking On"
      @car.parking_on
    else
      @car.parking_off
    end

    session[:car] = @car.to_yaml
    redirect_to "/simulator/do"
    #render "do.html.erb"
  end



end
