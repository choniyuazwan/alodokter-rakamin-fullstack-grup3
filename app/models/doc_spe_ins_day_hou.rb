class DocSpeInsDayHou < ApplicationRecord
  belongs_to :doc_spe_ins_day
  belongs_to :hour
  validates :doc_spe_ins_day_id, :hour_id, presence: true, length: { minimum: 1 }
end
