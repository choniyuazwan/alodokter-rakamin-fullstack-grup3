class CreateBookings < ActiveRecord::Migration[6.1]
  def change
    create_table :bookings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :doctors_specializations_institutions_days_hour, null: false, foreign_key: true

      t.timestamps
    end
  end
end
