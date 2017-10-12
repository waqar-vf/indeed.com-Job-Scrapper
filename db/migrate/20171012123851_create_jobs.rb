class CreateJobs < ActiveRecord::Migration[5.1]
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :company
      t.string :city
      t.string :state
      t.string :posted_date

      t.timestamps
    end
  end
end
