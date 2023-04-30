class CreateConnections < ActiveRecord::Migration[7.0]
  def change
    create_table :connections do |t|
      t.references :customer, null: false, foreign_key: true
      t.string :external_id, null: false, index: { unique: true }
      t.string :secret, null: false
      t.string :provider_id
      t.string :provider_code, null: false, index: true
      t.string :provider_name, null: false
      t.timestamp :next_refresh_possible_at
      t.timestamp :created_at, null: false
      t.timestamp :updated_at, null: false
      t.string :status, null: false
      t.string :categorization
      t.boolean :daily_refresh, null: false
      t.boolean :store_credentials, null: false
      t.string :country_code
      t.timestamp :last_success_at
      t.boolean :show_consent_confirmation, null: false
      t.string :last_consent_id
      t.jsonb :last_attempt, null: false, default: {}
    end
  end
end
