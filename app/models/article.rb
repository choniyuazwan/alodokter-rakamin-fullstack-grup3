class Article < ApplicationRecord
  belongs_to :category
  belongs_to :reviewer
  validates :title, presence: true, length: { minimum: 3 }

  def self.query(search, category)
    result = search ? where("title LIKE ?", "%#{search}%") : all
    category ? result.where("category_id = ?", "#{category}") : result
  end
end
