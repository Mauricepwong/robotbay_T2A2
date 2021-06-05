class RobotsController < ApplicationController
  
  # pull the specific robot from the database and sets it before a method is run. 
  before_action :set_robot, only: %i[show edit update destroy]
  
  # prompts for login if user not signed in
  before_action :authenticate_user!, except: %i[index]

  # ensure user has permission to change that robot.
  before_action :access_robot, only: %i[edit update destroy]

  rescue_from RuntimeError, with: :unauthorised

  # Unathorised method to only allow users to edit their own robots
  def unauthorised
    flash[:notice] = 'You are not authorised to change this robot'
    redirect_to robots_path
  end

  # Index page to list all robots that have not been sold yet.  
  def index
    @robots = Robot.where.missing(:sale).order(params[:sort])
  end

  # Initialise a new robot
  def new
    @robot = Robot.new
  end

  # Method to create robot 
  def create
    @robot = Robot.new(robot_params)
    if @robot.save
      flash[:notice] = 'Robot was successfully created'
      redirect_to robots_path
    else
      redirect_to new_robot_path,
      flash[:notice] = 'Error saving robot. Please try again'
    end
  end

  def show 
  end

  def edit 
  end

  # Method to update a specific robot
  def update
    if @robot.update(robot_params)
      flash[:notice] = 'Robot was successfully updated'
      redirect_to @robot
    else
      redirect_to @robot,
      flash[:notice] = 'Error updating robot. Please try again'
    end
  end

  # Destroys a specific 
  def destroy
    @robot.destroy
    flash[:notice] = 'Robot was successfully deleted'
    redirect_to robots_path
  end
  
  # Retrieves from database for a specific user the robots that they listed, have sold and purchased.  
  def myrobots
    @current_robots = current_user.robots.where.missing(:sale)
    @sold_robots = current_user.sold_robots
    @purchased_robots = current_user.purchased_robots
  end

  private

  # Calls the database based on the params to find a specifc robot.
  def set_robot
    begin
      @robot = Robot.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = 'That robot does not exist'
      redirect_to robots_path
    end
  end

  # Prevent any user besides the owner to edit a robot
  def access_robot
    raise 'unauthorised' if current_user != @robot.user
  end

  def robot_params
    params.require(:robot).permit(:name, :description, :price, :image, :user_id, category_ids: [])
  end
end
