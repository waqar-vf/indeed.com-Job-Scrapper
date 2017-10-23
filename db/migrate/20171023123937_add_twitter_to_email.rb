class AddTwitterToEmail < ActiveRecord::Migration[5.1]
  def change
    add_column :emails, :twitter, :string
  end
end
