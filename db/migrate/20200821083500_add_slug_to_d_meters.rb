class AddSlugToDMeters < ActiveRecord::Migration[6.0]
  def change
    add_column :d_meters, :slug, :string
    add_index :d_meters, :slug, unique: true
  end
end
