class CreateInvites < ActiveRecord::Migration[6.0]
  def change
    create_table :invites do |t|
      t.references :d_meter, null: false, foreign_key: true
      t.string :uid
      t.string :email
      t.boolean :active, default: false

      t.timestamps
    end
  end
end
