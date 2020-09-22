class AddPublicToDMeters < ActiveRecord::Migration[6.0]
  def change
    add_column :d_meters, :public, :boolean
  end
end
