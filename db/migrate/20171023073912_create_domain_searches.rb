class CreateDomainSearches < ActiveRecord::Migration[5.1]
  def change
    create_table :domain_searches do |t|
      t.string :domain
      t.string :result
      t.integer :company_id

      t.timestamps
    end
  end
end
