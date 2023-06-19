class Patient < ApplicationRecord
  has_many :patch_form
  has_many :prick_form
  has_many :immunotherapy
  validates :cpf, uniqueness: true
end
