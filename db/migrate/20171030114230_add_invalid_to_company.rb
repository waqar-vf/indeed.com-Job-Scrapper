class AddInvalidToCompany < ActiveRecord::Migration[5.1]
  def change
    add_column :companies, :invalid_address, :boolean , default: false
  end
end
