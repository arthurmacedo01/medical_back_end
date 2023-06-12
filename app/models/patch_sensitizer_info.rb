class PatchSensitizerInfo < ApplicationRecord
  belongs_to :patch_test_info
  has_many :patch_measurement
end
