class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users, id: :uuid do |t|
      t.string :username, null: false
      t.timestamps

      t.index :username, unique: true
    end
  end
end
