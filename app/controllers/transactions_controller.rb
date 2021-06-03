class TransactionsController < ApplicationController
before_action :set_robot, only: [:create]
before_action :authenticate_user!        
skip_before_action :verify_authenticity_token, only: [:create]
    
    def create
      # robot = Robot.find params["id"]
        session = Stripe::Checkout::Session.create({
            payment_method_types: ['card'],
            line_items: [{
              price_data: {
                unit_amount: @robot.price*100,
                currency: 'usd',
                product_data: {
                  name: @robot.name,
                },
              },
              quantity: 1,
            }],
            mode: 'payment',
            success_url: checkout_success_url,
            cancel_url: checkout_cancel_url,
          })

          render json: { id: session.id }
    end

    def success

    end

    def cancel
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
end
