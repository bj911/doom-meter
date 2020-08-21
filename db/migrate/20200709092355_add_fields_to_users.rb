class AddFieldsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :admin, :boolean, default: false
    add_column :users, :username, :string
    add_index :users, :username, unique: true
    add_column :users, :tos_agreement, :boolean, default:  false
  end
end
