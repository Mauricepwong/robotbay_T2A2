class TransactionsController < ApplicationController
  before_action :set_robot, only: [:create]
  before_action :authenticate_user!
  before_action :access_buy
  skip_before_action :verify_authenticity_token, only: [:create]

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

  def success
    transaction =
      Transaction.create(
        buyer_id: params[:buyer_id],
        robot_id: params[:robot_id],
        seller_id: params[:user_id]
      )
  end

  def cancel; end

  def unauthorised
    flash[:notice] = 'You are not authorised to buy your own robot'
    redirect_to robots_path
  end

  private

  def set_robot
    begin
      @robot = Robot.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = 'That robot does not exist'
      redirect_to robots_path
    end
  end

  def access_buy
    raise 'unauthorised' if current_user == @robot.user
  end
end