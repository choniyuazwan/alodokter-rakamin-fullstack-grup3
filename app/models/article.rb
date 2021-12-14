class Article < ApplicationRecord
  belongs_to :category
  validates :title, presence: true, length: { minimum: 3 }
end
