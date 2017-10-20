class AddBatchToJob < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :batch_id, :integer
  end
end
