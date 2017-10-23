class CreateEmails < ActiveRecord::Migration[5.1]
  def change
    create_table :emails do |t|
      t.string :email
      t.string :type
      t.string :status
      t.string :first_name
      t.string :last_name
      t.string :position
      t.string :source_page
      t.integer :domain_search_id

      t.timestamps
    end
  end
end
