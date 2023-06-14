class PrickElementInfo < ApplicationRecord
  belongs_to :prick_test_info
  belongs_to :prick_group_info, optional: true
  has_many :prick_measurement
end
