class AuthenticateRestaurant
  prepend SimpleCommand

  def initialize(otp)
    @otp = otp
  end

  def call
    if restaurant
       JsonWebToken.encode(restaurant_id: restaurant.id)
    end
  end

  private

  attr_accessor :otp 

  def restaurant
    restaurant = Restaurant.find_by(otp: otp)

    return restaurant if restaurant

    errors.add :restaurant_authentication, 'invalid otp'
    nil
  end
end

