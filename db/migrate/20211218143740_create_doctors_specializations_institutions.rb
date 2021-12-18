class CreateDoctorsSpecializationsInstitutions < ActiveRecord::Migration[6.1]
  def change
    create_table :doctors_specializations_institutions do |t|
      t.references :doctors_specialization, null: false, foreign_key: true
      t.references :institution, null: false, foreign_key: true
      t.integer :price

      t.timestamps
    end
  end
end
