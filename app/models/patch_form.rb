class PatchForm < ApplicationRecord
  belongs_to :patient
  has_many :patch_measurement
end
