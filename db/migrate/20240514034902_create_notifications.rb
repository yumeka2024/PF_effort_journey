class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, foreign_key: { to_table: :posts }
      t.references :sender, null: false, foreign_key: { to_table: :users }
      t.references :notifiable, polymorphic: true
      t.boolean :read, default: false, null: false
      t.integer :message, null: false

      t.timestamps
    end

  end
end
