class CreateDocSpeInsDayHous < ActiveRecord::Migration[6.1]
  def change
    create_table :doc_spe_ins_day_hous do |t|
      t.references :doc_spe_ins_day, null: false, foreign_key: true
      t.references :hour, null: false, foreign_key: true
      t.date :date
      t.boolean :is_active

      t.timestamps
    end
  end
end
