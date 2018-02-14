class CreateDevices < ActiveRecord::Migration[5.1]
  def change
    enable_extension 'uuid-ossp'
    create_table :devices do |t|
      t.uuid :code, default: -> { "uuid_generate_v4()" }
      t.string :name
      t.integer :mac_address

      t.timestamps
    end
  end
end
