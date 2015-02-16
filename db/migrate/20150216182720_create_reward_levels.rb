class CreateRewardLevels < ActiveRecord::Migration
  def change
    create_table :reward_levels do |t|
      t.references :campaign, index: true
      t.string :title
      t.integer :amount
      t.text :body
      t.integer :quantity

      t.timestamps null: false
    end
    add_foreign_key :reward_levels, :campaigns
  end
end
