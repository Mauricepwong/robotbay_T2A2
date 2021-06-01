class RobotsController < ApplicationController
  before_action :set_robot, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  rescue_from RuntimeError, with: :unauthorised

  def unauthorised
    flash[:alert] = "You are not authorised to change this robot"
    redirect_to robots_path
  end


  def index
    @robots = Robot.all
  end
  

  def new
    @robot = Robot.new
  end

  def create
    @robot = Robot.new(robot_params)

    if @robot.save 
      flash[:notice] = "Robot was successfully created"
      redirect_to robots_path
    else
      redirect_to new_robot_path, flash[:notice] = "Error saving robot. Please try again"
    end
  end

  def show
    @robot = Robot.find do |robot|
      robot[:id] == params[:id].to_i 
    end
  end

  def edit
    raise "unauthorised" if current_user != @robot.user
  end

  def update
    if @robot.update(robot_params)
      flash[:notice] = "Robot was successfully updated"
      redirect_to @robot
    else
      redirect_to @robot, flash[:notice] = "Error updating robot. Please try again"
    end
  end

  def destroy
    @robot.destroy
    flash[:notice] = "Robot was successfully deleted"
    redirect_to robots_path
  end

  private
  def set_robot
    begin
      @robot = Robot.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "That robot does not exist"
      redirect_to robots_path 
    end
  end

 def robot_params
  params.require(:robot).permit(:name, :description, :price, :image, :user_id)
 end
end
