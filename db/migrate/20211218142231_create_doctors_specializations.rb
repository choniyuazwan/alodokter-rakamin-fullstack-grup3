class CreateDoctorsSpecializations < ActiveRecord::Migration[6.1]
  def change
    create_table :doctors_specializations do |t|
      t.references :doctor, null: false, foreign_key: true
      t.references :specialization, null: false, foreign_key: true

      t.timestamps
    end
  end
end