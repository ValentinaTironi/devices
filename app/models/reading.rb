class Reading < ApplicationRecord
  belongs_to :device
  accepts_nested_attributes_for :device

  validates :value, presence: true
end
