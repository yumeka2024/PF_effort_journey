class CreatePunchLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :punch_logs do |t|
      t.references :punch, null: false, foreign_key: true
      t.string :reason
      t.string :detail
      t.datetime :in_time, null: false
      t.datetime :out_time

      t.timestamps
    end
  end
end
