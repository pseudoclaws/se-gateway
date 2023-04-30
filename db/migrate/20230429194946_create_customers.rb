class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.references :user, null: false, foreign_key: true, index: { unique: true }
      t.string :identifier, null: false
      t.string :external_id, null: false, index: { unique: true }
      t.string :secret, null: false

      t.timestamps
    end
  end
end
