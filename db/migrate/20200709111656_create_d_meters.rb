class CreateDMeters < ActiveRecord::Migration[6.0]
  def change
    create_table :d_meters do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :link
      t.string :doom_lvl_0
      t.string :doom_lvl_1
      t.string :doom_lvl_2
      t.string :doom_lvl_3
      t.string :doom_lvl_4
      t.string :doom_lvl_5
      t.string :doom_lvl_6
      t.string :doom_lvl_7
      t.string :doom_lvl_8
      t.string :doom_lvl_9
      t.string :doom_lvl_10
      t.string :doom_lvl_11
      t.string :doom_lvl_12
      t.integer :count_days, default: 14

      t.timestamps
    end
  end
end
