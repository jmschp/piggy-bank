class CreateFamilies < ActiveRecord::Migration[6.0]
  def change
    create_table :families do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end