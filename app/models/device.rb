class Device < ApplicationRecord

  validates :name, :mac_address, presence: true
  validates :code, uniqueness: true
  
end
