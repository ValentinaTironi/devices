class CreateReadings < ActiveRecord::Migration[5.1]
  def change
    create_table :readings do |t|
      t.string :value
      t.date :date
      t.references :device, foreign_key: true

      t.timestamps
    end
  end
end
