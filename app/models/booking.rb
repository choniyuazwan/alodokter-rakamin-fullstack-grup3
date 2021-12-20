class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :doc_spe_ins_day_hou
  validates :user_id, :doc_spe_ins_day_hou_id, presence: true, length: { minimum: 1 }
end
