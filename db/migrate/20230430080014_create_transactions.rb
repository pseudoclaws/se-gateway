class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.references :account, null: false, foreign_key: true
      t.string :external_id, null: false, index: { unique: true }
      t.boolean :duplicated, null: false
      t.string :mode, null: false
      t.string :status, null: false
      t.date :made_on, null: false
      t.decimal :amount, precision: 12, scale: 2, null: false
      t.string :currency_code, null: false
      t.string :description
      t.string :category
      t.timestamp :created_at, null: false
      t.timestamp :updated_at, null: false
      t.jsonb :extra, null: false, default: {}
    end
  end
end
