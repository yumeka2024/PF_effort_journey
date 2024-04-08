class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.date :posted_on, null: false
      t.text :body, null: false

      t.timestamps
    end
  end
end
