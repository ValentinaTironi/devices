class User < ApplicationRecord

  has_many :devices, dependent: :destroy
  accepts_nested_attributes_for :devices

  validates :first_name, :last_name, :email, presence: true

end
