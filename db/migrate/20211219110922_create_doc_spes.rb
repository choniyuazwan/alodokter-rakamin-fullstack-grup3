class CreateDocSpes < ActiveRecord::Migration[6.1]
  def change
    create_table :doc_spes do |t|
      t.references :doctor, null: false, foreign_key: true
      t.references :specialization, null: false, foreign_key: true

      t.timestamps
    end
  end
end
