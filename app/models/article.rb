class Article < ApplicationRecord
  belongs_to :category
  belongs_to :reviewer
  validates :title, presence: true, length: { minimum: 3 }
end
