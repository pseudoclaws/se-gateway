class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.references :connection, null: false, foreign_key: true
      t.string :external_id, null: false, index: { unique: true }
      t.string :nature, null: false
      t.decimal :balance, null: false, precision: 12, scale: 2
      t.string :currency_code, null: false
      t.timestamp :created_at, null: false
      t.timestamp :updated_at, null: false
      t.jsonb :extra, null: false, default: {}
    end
  end
end
