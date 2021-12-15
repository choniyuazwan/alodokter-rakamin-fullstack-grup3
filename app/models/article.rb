class Article < ApplicationRecord
  belongs_to :category
  belongs_to :reviewer
  validates :title, presence: true, length: { minimum: 3 }

  def self.query(search, category, headline)
    result = search ? where("title LIKE ?", "%#{search}%") : all
    result = category ? result.where("category_id = ?", "#{category}") : result
    headline ? result.where("headline = ?", "#{headline}") : result
  end
end
