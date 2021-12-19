class CreateDocSpeInsDays < ActiveRecord::Migration[6.1]
  def change
    create_table :doc_spe_ins_days do |t|
      t.references :doc_spe_in, null: false, foreign_key: true
      t.references :day, null: false, foreign_key: true

      t.timestamps
    end
  end
end
