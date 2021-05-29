class RobotsController < ApplicationController
  before_action :set_robot, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @robots = Robot.all
  end
  

  def new
    @robot = Robot.new
  end

  def create
    @robot = Robot.create(robot_params)
    redirect_to robots_path
  end

  def show
    @robot = Robot.find do |robot|
      robot[:id] == params[:id].to_i 
    end
  end

  def edit
  end

  def update
    @robot.update(robot_params)
    redirect_to robot_path
  end

  def destroy
    @robot.destroy
    redirect_to robots_path, notice: "Robot was successfully deleted"
  end

  private
  def set_robot
   @robot = Robot.find(params[:id])
  end

 def robot_params
  params.require(:robot).permit(:name, :description, :price, :image, :user_id)
 end
end
