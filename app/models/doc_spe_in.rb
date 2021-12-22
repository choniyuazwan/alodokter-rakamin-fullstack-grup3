class DocSpeIn < ApplicationRecord
  belongs_to :doc_spe
  belongs_to :institution
  has_many :doc_spe_ins_days
  validates :doc_spe_id, :institution_id, presence: true, length: { minimum: 1 }
end
