class CreateFallbackUsernames < ActiveRecord::Migration[7.1]
  def change
    create_table :fallback_usernames, id: :uuid do |t|
      t.string :username, null: false
      t.timestamps

      t.index :username, unique: true
    end
  end
end
