class ChangeMacAddressTypeInDevices < ActiveRecord::Migration[5.1]
  def change
    change_column :devices, :mac_address, :bigint
  end
end
