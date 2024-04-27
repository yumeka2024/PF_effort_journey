class CreateLabels < ActiveRecord::Migration[6.1]
  def change
    create_table :labels do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :genre, null: false
      t.string :name, null: false

      t.timestamps
    end
  end
end
