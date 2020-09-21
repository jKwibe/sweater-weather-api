class User < ApplicationRecord
  validates :email, presence: true,
                    uniqueness: true,
                    format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/ }
  validates :password, presence: true

  has_secure_password
end
