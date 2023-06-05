class PatchMeasurement < ApplicationRecord
  belongs_to :sensitizer
  belongs_to :patch_form
end
