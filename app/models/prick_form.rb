class PrickForm < ApplicationRecord
  belongs_to :patient
  has_many :prick_measurement
end
