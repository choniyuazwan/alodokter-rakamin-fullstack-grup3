class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :firstname
      t.string :lastname
      t.string :birthdate
      t.string :gender
      t.string :phone
      t.string :identity
      t.string :address
      t.string :city

      t.timestamps
    end
  end
end
