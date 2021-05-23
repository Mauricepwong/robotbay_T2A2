class RobotsController < ApplicationController
  def index
    @robots = Robot.all
  end
  

  def new
    @robot = Robot.new
  end

  def create
  end

  def show
    @robot = Robot.find do |robot|
      robot[:id] == params[:id].to_i 
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
 # def set_robot
 #   @robot = Robot.find(params[:id])
 # end
end
