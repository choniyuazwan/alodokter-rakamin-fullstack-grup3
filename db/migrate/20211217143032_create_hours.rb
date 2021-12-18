class CreateHours < ActiveRecord::Migration[6.1]
  def change
    create_table :hours do |t|
      t.string :name

      t.timestamps
    end
  end
end
