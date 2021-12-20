class CreateBookings < ActiveRecord::Migration[6.1]
  def change
    create_table :bookings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :doc_spe_ins_day_hou, null: false, foreign_key: true

      t.timestamps
    end
  end
end
