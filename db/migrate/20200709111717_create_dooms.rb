class CreateDooms < ActiveRecord::Migration[6.0]
  def change
    create_table :dooms do |t|
      t.references :user, null: false, foreign_key: true
      t.references :d_meter, null: false, foreign_key: true
      t.string :level
      t.text :text
      t.boolean :active, default:true

      t.timestamps
    end
  end
end
