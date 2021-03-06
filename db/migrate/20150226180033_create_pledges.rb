class CreatePledges < ActiveRecord::Migration
  def change
    create_table :pledges do |t|
      t.integer :amount
      t.string :stripe_txn_id
      t.string :aasm_state
      t.references :user, index: true
      t.references :reward_level, index: true

      t.timestamps null: false
    end
    add_foreign_key :pledges, :users
    add_foreign_key :pledges, :reward_levels
  end
end
