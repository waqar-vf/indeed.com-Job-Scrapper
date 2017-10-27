class AddBatchIdToCompany < ActiveRecord::Migration[5.1]
  def change
    add_column :companies, :batch_id, :integer
  end
end
