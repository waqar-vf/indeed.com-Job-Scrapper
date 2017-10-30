class AddBatchTypeToBatch < ActiveRecord::Migration[5.1]
  def change
    add_column :batches, :batch_type, :string , default: "search"
  end
end
