class CreateGoals < ActiveRecord::Migration[6.0]
  def change
    create_table :goals do |t|
      t.string :title, null: false
      t.integer :points, null: false, default: 0
      t.boolean :finished, null: false, default: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
