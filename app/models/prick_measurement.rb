class PrickMeasurement < ApplicationRecord
  belongs_to :prick_element_info
  belongs_to :prick_form
end
