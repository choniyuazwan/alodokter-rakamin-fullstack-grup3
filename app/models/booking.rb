class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :doc_spe_ins_day_hou
end
