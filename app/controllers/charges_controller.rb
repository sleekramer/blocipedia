class ChargesController < ApplicationController

  # I don't see much value in this class
  # class Amount
  #   def self.default
  #     15_00
  #   end
  # end


  def create
    if current_user.customer_id && current_user.premium?
      flash[:notice] = "Already a premium member. Account not charged."
      redirect_to user_wikis_path(current_user)
    else

    if CreateStripeCharge.call(current_user, params[:stripeToken])
      flash[:notice] = "Thank you, #{current_user.email}, for becoming a premium member.  Your account has been charged $5.  Go create your first private wiki!"
      redirect_to (user_wikis_path(current_user)|| root_path)
    else
      flash[:alert] = "Account not charged. Please try again."
      redirect_to new_charge_path
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
    current_user.wikis.where(private: true).each do |wiki|
      wiki.update(private: false)
    end
    redirect_to user_wikis_path(current_user)
  end
end
