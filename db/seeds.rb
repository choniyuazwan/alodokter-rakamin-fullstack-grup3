# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

# Article.destroy_all
# Category.destroy_all
# Reviewer.destroy_all
DocSpeInsDayHou.destroy_all
DocSpeInsDay.destroy_all
DocSpeIn.destroy_all
DocSpe.destroy_all

# ActiveRecord::Base.connection.reset_pk_sequence!('categories')
# ActiveRecord::Base.connection.reset_pk_sequence!('reviewers')
# ActiveRecord::Base.connection.reset_pk_sequence!('articles')
ActiveRecord::Base.connection.reset_pk_sequence!('doc_spes')
ActiveRecord::Base.connection.reset_pk_sequence!('doc_spe_ins')
ActiveRecord::Base.connection.reset_pk_sequence!('doc_spe_ins_days')
ActiveRecord::Base.connection.reset_pk_sequence!('doc_spe_ins_day_hous')

[{name: 'Hidup Sehat'}, {name: 'Keluarga'}, {name: 'Kesehatan'}].each do |attributes|
  Category.find_or_initialize_by(name: attributes[:name]).update!(attributes)
end

[{name: 'dr Habibie Gusdur'}, {name: 'dr Susilo Widodo'}, {name: 'dr Soekarno Soeharto'}].each do |attributes|
  Reviewer.find_or_initialize_by(name: attributes[:name]).update!(attributes)
  Doctor.find_or_initialize_by(name: attributes[:name]).update!(attributes)
end

[{name: 'Gigi Umum'}, {name: 'Gigi Anak'}, {name: 'Konservasi Gigi'}].each do |attributes|
  Specialization.find_or_initialize_by(name: attributes[:name]).update!(attributes)
end

[{name: 'Senin'}, {name: 'Selasa'}, {name: 'Rabu'}, {name: 'Kamis'}, {name: 'Jumat'}, {name: 'Sabtu'}, {name: 'Minggu'}].each do |attributes|
  Day.find_or_initialize_by(name: attributes[:name]).update!(attributes)
end

24.times do |hour|
  Hour.find_or_initialize_by(name: "#{hour+1}:00").update!({name: "#{hour+1}:00"})
end

[
    {name: 'RS Bunda Margonda', location: 'Beji, Depok', latitude: '-6.365184557626885', longitude: '106.8344676860832'}, 
    {name: 'RS Citra Arafiq', location: 'Sukmajaya, Depok', latitude: '-6.372605488228749', longitude: '106.84366315726945'},
    {name: 'RS UI', location: 'Beji, Depok', latitude: '-6.371675264962441', longitude: '106.82986022219062'}, 
].each do |attributes|
  Institution.find_or_initialize_by(name: attributes[:name]).update!(attributes)
end

CSV.foreach(Rails.root.join('db/seeds/article_seeds.csv'), headers: true) do |row| 
  Article.find_or_initialize_by(title: row[0]).update!(
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

(1..3).each { |i|
  (1..2).each { |j|
    DocSpe.create(
        {
            doctor_id: i,
            specialization_id: j
        }
    ) 
  }
}

(1..9).each { |i|
  (1..2).each { |j|
    DocSpeIn.create(
        {
            doc_spe_id: i,
            institution_id: j,
            price: 100000*j
        }
    )
  }
}

(1..9).each { |i|
  (1..2).each { |j|
    DocSpeInsDay.create(
        {
            doc_spe_in_id: i,
            day_id: j
        }
    )
  }
}

(1..27).each { |i|
  (1..2).each { |j|
    DocSpeInsDayHou.create(
        {
            doc_spe_ins_day_id: i,
            hour_id: j,
            date: DateTime.current.to_date,
            is_active: true
        }
    )
  }
}