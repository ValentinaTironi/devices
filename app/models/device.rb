class Device < ApplicationRecord

  validates :name, presence: true
  validates :mac_address, presence: true

end
