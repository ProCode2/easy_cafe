class User < ApplicationRecord
  has_secure_password
  has_many :orders
  has_one :cart

  def self.create_user(name, email, digest, role = "customer")
    new_user = new(
      name: name,
      email: email,
      password: digest,
      role: role
    )

    if new_user.save
      return {
        success: true,
        error: nil
      }
    else
      return {
        success: false,
        error: new_user.errors.full_messages
      }
    end
  end
end
