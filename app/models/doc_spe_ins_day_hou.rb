class DocSpeInsDayHou < ApplicationRecord
  belongs_to :doc_spe_ins_day
  belongs_to :hour
  validates :doc_spe_ins_day_id, :hour_id, presence: true, length: { minimum: 1 }

  def self.query(search, category, headline)
    # result = search ? where("lower(title) LIKE ?", "%#{search.downcase}%") : all
    # result = category ? result.where("category_id = ?", "#{category}") : result
    # headline ? result.where("headline = ?", "#{headline}") : result.where(headline: [nil, false])
  end
end
