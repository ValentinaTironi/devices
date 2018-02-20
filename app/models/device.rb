class Device < ApplicationRecord
  
  belongs_to :user
  accepts_nested_attributes_for :user

  validates :name, :mac_address, presence: true
  validates :code, uniqueness: true

end
