# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

Article.destroy_all
Category.destroy_all
Reviewer.destroy_all

ActiveRecord::Base.connection.reset_pk_sequence!('categories')
ActiveRecord::Base.connection.reset_pk_sequence!('reviewers')
ActiveRecord::Base.connection.reset_pk_sequence!('articles')

[{name: 'Hidup Sehat'}, {name: 'Keluarga'}, {name: 'Kesehatan'}].each do |attributes|
  Category.find_or_initialize_by(name: attributes[:name]).update!(attributes)
end

[{name: 'dr Habibie Gusdur'}, {name: 'dr Susilo Widodo'}, {name: 'dr Soekarno Soeharto'}].each do |attributes|
  Reviewer.find_or_initialize_by(name: attributes[:name]).update!(attributes)
end

CSV.foreach(Rails.root.join('db/seeds/article_seeds.csv'), headers: true) do |row| 
  Article.create(
      {
          title: row[0], 
          category_id: row[1],
          content: row[2],
          image: row[3],
          reviewer_id: row[4],
          headline: row[5]
      }
  )
end