class AddPublicToDMeters < ActiveRecord::Migration[6.0]
  def change
    add_column :d_meters, :public, :boolean
  end

  DMeter.first.update(public: true) if DMeter.first.present?
end
