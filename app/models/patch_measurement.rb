class PatchMeasurement < ApplicationRecord
  belongs_to :patch_sensitizer_info
  belongs_to :patch_form
end
