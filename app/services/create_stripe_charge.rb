class CreateStripeCharge

  def self.call(user, stripe_token)
    @customer = create_customer(user, stripe_token)
    charge = create_charge
    if charge.paid
      user.update(customer_id: @customer.id)
      user.premium!
    else
      false
    end
  end

  private
  def self.create_customer(user, stripe_token)
    Stripe::Customer.create(
      email: user.email,
      card: stripe_token
    )
  end

  def self.create_charge
    Stripe::Charge.create(
      customer: @customer.id,
      amount: 15_00,
      description: "Premium Membership",
      currency: 'usd'
    )
  end
end
