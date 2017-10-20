class AddCompanyToJob < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :company_id, :integer
  end
end
