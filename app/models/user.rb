class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true
  has_many :orders, dependent: :destroy
  has_one :cart

  def self.clerks
    all.where(role: "clerk")
  end

  def self.customers
    all.where(role: "customer")
  end

  def self.create_user(name, email, digest, role = "customer")
    new_user = new(
      name: name,
      email: email,
      password: digest,
      role: role,
    )

    if new_user.save
      return {
               success: new_user,
               error: nil,
             }
    else
      return {
               success: false,
               error: new_user.errors.full_messages.join("\n"),
             }
    end
  end

  def self.delete_user(id)
    user = find_by(id: id)
    user.destroy
    user.destroyed?
  end

  # Authorization functions
  def owner?
    role == "owner"
  end

  def clerk?
    role == "clerk"
  end
end
