class RenameTypeToAddressType < ActiveRecord::Migration[5.1]
  def change
    rename_column :emails, :type, :address_type
  end
end
