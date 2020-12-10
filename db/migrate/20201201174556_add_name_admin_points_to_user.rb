class AddNameAdminPointsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string, null: false
    add_column :users, :admin, :boolean, null: false, default: false
    add_column :users, :points, :integer, null: false, default: 0
    add_column :users, :phone, :string, null: false, default: nil
    add_reference :users, :family, null: true, foreign_key: true
  end
end
