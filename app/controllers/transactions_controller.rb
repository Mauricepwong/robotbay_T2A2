class TransactionsController < ApplicationController
  before_action :set_robot, only: [:create]
  before_action :authenticate_user!
  before_action :access_buy, only: [:create]
  skip_before_action :verify_authenticity_token, only: [:create]

  rescue_from RuntimeError, with: :unauthorised

  # This method sends information to stripe, make payment then redirects to success or failure page. 
  def create
    session =
      Stripe::Checkout::Session.create(
        {
          payment_method_types: ['card'],
          line_items: [
            {
              price_data: {
                unit_amount: @robot.price * 100,
                currency: 'aud',
                product_data: {
                  name: @robot.name
                }
              },
              quantity: 1
            }
          ],
          mode: 'payment',
          success_url:
            checkout_success_url +
            "?buyer_id=#{current_user.id}&robot_id=#{@robot.id}&user_id=#{@robot.user_id}",
          cancel_url: checkout_cancel_url
        }
      )

    render json: { id: session.id }
  end

  # After payment is successful, transaction record is created, adding a buyer and seller. 
  # the robot atribute is also updated to sold. 

  def success
    tranaction =
      Transaction.create(
        buyer_id: params[:buyer_id],
        robot_id: params[:robot_id],
        seller_id: params[:user_id]
      )
    robot = Robot.find(params[:robot_id])
    robot.update(sold: true)
  end

  def cancel 
  end

  def unauthorised
    flash[:alert] = 'This process is not authorised'
    redirect_to robots_path
  end

  private

  # Sets the robot for a particular method before method is executed. 
  def set_robot
    begin
      @robot = Robot.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = 'That robot does not exist'
      redirect_to robots_path
    end
  end

  # Ensure that an owner cannot buy their own robot. 
  def access_buy
    if current_user == @robot.user 
      raise 'unauthorised' 
    end
  end

end
