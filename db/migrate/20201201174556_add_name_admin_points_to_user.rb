class AddNameAdminPointsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string, null: false
    add_column :users, :admin, :boolean, null: false
    add_column :users, :points, :integer, null: false, default: 0
    add_reference :users, :family, null: false, foreign_key: true
  end
end