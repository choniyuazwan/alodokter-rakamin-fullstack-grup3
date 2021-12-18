class CreateDoctorsSpecializationsInstitutionsDaysHours < ActiveRecord::Migration[6.1]
  def change
    create_table :doctors_specializations_institutions_days_hours do |t|
      t.references :doctors_specializations_institutions_day, null: false, foreign_key: true
      t.references :hour, null: false, foreign_key: true
      t.date :date
      t.boolean :is_active

      t.timestamps
    end
  end
end
