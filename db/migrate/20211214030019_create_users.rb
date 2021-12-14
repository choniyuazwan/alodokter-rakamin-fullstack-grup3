class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :fullname
      t.date :birthdate
      t.string :gender
      t.string :phone
      t.string :identity
      t.string :address

      t.timestamps
    end
  end
end
