class Patient < ApplicationRecord
  has_many :patch_form
  has_many :immunotherapy
end
