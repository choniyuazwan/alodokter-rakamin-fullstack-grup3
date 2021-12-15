class CreateArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.references :category, null: false, foreign_key: true
      t.string :content
      t.string :image
      t.references :reviewer, null: false, foreign_key: true
      t.boolean :headline

      t.timestamps
    end
  end
end
