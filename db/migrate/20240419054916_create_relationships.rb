class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.integer :follower_id, null: false
      t.integer :followed_id, null: false
      t.boolean :approved, null: false, default: true

      t.timestamps
    end
    add_index :relationships, :follower_id
    add_index :relationships, :followed_id
  end
end
