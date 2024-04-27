class CreatePunches < ActiveRecord::Migration[6.1]
  def change
    create_table :punches do |t|
      t.references :user, null: false, foreign_key: true
      t.references :label, null: false, foreign_key: true
      t.string :reason
      t.string :detail
      t.datetime :in, null: false
      t.datetime :out

      t.timestamps
    end
  end
end
