class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  belongs_to :user

  def self.create_cart(current_user)
    current_user.cart = Cart.find_or_create_by!(user_id: current_user.id)
  end
end
