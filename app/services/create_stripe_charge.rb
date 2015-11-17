class CreateStripeCharge

  def self.call(user, stripe_token)
    @customer = create_customer 
    @stripe_token = stripe_token
    charge = create_charge 
    if charge.paid
      user.update(customer_id: customer.id)
      user.premium! # returns true
    else
      false
    end
  end

  private
  def create_customer
    Stripe::Customer.create(
      email: user.email,
      card: @stripe_token 
    )
  end

  def create_charge
    Stripe::Charge.create(
      customer: @customer.id,
      amount: 15_00,
      description: "Premium Membership",
      currency: 'usd'
    )
  end

end
