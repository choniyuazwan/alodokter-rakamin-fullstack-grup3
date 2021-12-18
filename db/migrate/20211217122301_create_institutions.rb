class CreateInstitutions < ActiveRecord::Migration[6.1]
  def change
    create_table :institutions do |t|
      t.string :name
      t.string :location
      t.string :latitude
      t.string :longitude

      t.timestamps
    end
  end
end
