class CreateTables < ActiveRecord::Migration[8.0]
  def change
    create_table :sns do |t|
      t.string :uuid, null: false
      t.integer :t_us, null: false
      t.string :title, null: false, default: ""
      t.string :body, null: false, default: ""
      t.integer :read, null: false, default: 0

      t.timestamps
    end
    add_index :sns, :uuid, unique: true
    add_index :sns, :t_us
    add_index :sns, :read

    create_table :sn_subscriptions do |t|
      t.string :endpoint, null: false, default: ""
      t.string :p256dh, null: false, default: ""
      t.string :auth, null: false, default: ""

      t.timestamps
    end
  end
end
