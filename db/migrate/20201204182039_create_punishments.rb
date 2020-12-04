class CreatePunishments < ActiveRecord::Migration[6.0]
  def change
    create_table :punishments do |t|
      t.string :title, null: false
      t.integer :points, null: false, default: 0
      t.date :date
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
