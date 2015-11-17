class ChargesController < ApplicationController

  class Amount
    def self.default
      15_00
    end
  end

  # def create
  #   unless Stripe::Plan.retrieve(id: 'premium')
  #     Stripe::Plan.create(
  #       amount: Amount.default,
  #       interval: 'month',
  #       name: 'Premium Membership',
  #       currency: 'usd',
  #       id: 'premium'
  #     )
  #   end
  #
  #   customer = Stripe::Customer.create(
  #     email: current_user.email,
  #     source: params[:stripeToken],
  #     plan: 'premium'
  #   )

  #   if customer.subscriptions['total_count'] > 0
  #     current_user.premium!
  #     flash[:notice] = "Thank you, #{current_user.email}, for becoming a premium member.  Your account has been charged $5.  Go create your first private wiki!"
  #     redirect_to (user_wikis_path(current_user) || root_path)
  #   else
  #     flash[:alert] = "Account not charged. Please try again."
  #     redirect_to new_charge_path
  #   end
  # rescue Stripe::CardError => e
  #   flash[:alert] = e.message
  #   redirect_to new_charge_path
  # end

  def create
    if current_user.customer_id && current_user.premium?
      flash[:notice] = "Already a premium member. Account not charged."
      redirect_to user_wikis_path(current_user)
    else

      customer = Stripe::Customer.create(
        email: current_user.email,
        card: params[:stripeToken]
      )
    
      charge = Stripe::Charge.create(
        customer: customer.id,
        amount: Amount.default,
        description: "Premium Membership",
        currency: 'usd'
      )
      if charge.paid
        current_user.customer_id = customer.id
        current_user.premium!
        flash[:notice] = "Thank you, #{current_user.email}, for becoming a premium member.  Your account has been charged $5.  Go create your first private wiki!"
        redirect_to (user_wikis_path(current_user)|| root_path)
      else
        flash[:alert] = "Account not charged. Please try again."
        redirect_to new_charge_path
      end
    end
  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to new_charge_path
  end

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key]}",
      description: "Premium Membership",
      amount: Amount.default
    }
  end
  def downgrade
  end
  def to_standard
    current_user.standard!
    current_user.wikis.each do |wiki|
      if wiki.private
        wiki.update_attributes(private: false)
      else
        next
      end
    end
    redirect_to user_wikis_path(current_user)
  end
end
