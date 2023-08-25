class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :services, dependent: :destroy
  has_many :reviews, dependent: :destroy
   has_one_attached :user_profile
  def self.ransackable_attributes(auth_object = nil)
    ["address", "city", "created_at", "email", "id", "location", "name", "password_digest", "state", "user_type", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["reviews", "services"]
  end
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
