class Device < ApplicationRecord

  belongs_to :user
  accepts_nested_attributes_for :user

  has_many :readings
  accepts_nested_attributes_for :readings
  validates :name, :mac_address, presence: true
  validates :code, uniqueness: true

end
