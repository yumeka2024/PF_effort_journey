class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :sender_id, null: false
      t.references :notifiable, polymorphic: true, null: false
      t.boolean :read, default: false, null: false
      t.integer :message, null: false

      t.timestamps
    end
    add_index :notifications, :sender_id
  end
end
