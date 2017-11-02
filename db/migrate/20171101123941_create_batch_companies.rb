class CreateBatchCompanies < ActiveRecord::Migration[5.1]
  def change
    create_table :batch_companies do |t|
      t.integer :batch_id
      t.integer :company_id

      t.timestamps
    end
  end
end
