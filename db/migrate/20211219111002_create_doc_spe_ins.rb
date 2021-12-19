class CreateDocSpeIns < ActiveRecord::Migration[6.1]
  def change
    create_table :doc_spe_ins do |t|
      t.references :doc_spe, null: false, foreign_key: true
      t.references :institution, null: false, foreign_key: true
      t.integer :price

      t.timestamps
    end
  end
end
