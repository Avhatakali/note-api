class User < ApplicationRecord
  has_secure_password
  has_many :notes
  validates :username, :email, :password_digest, presence: true
end
