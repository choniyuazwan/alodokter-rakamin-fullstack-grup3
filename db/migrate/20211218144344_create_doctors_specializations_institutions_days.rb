class CreateDoctorsSpecializationsInstitutionsDays < ActiveRecord::Migration[6.1]
  def change
    create_table :doctors_specializations_institutions_days do |t|
      t.references :doctors_specializations_institution, null: false, foreign_key: true
      t.references :day, null: false, foreign_key: true

      t.timestamps
    end
  end
end
