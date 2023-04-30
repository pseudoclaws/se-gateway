class CreateConnectionSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :connection_sessions do |t|
      t.references :customer, null: false, foreign_key: true
      t.string :connect_url, null: false
      t.string :status, null: false, default: 'pending', index: true
      t.timestamp :expires_at, null: false

      t.timestamps
    end
  end
end
