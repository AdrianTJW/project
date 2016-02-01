class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
    	t.string :company_name
      t.string :description
      t.string :address
      t.string :country
      t.string :city
      t.string :type
      t.string :job_name
      t.json :images
      t.date :start_date
      t.date :end_date
      t.integer :host_id
      t.integer :user_id
      t.integer :content_id
    	
      t.timestamps null: false
    end
  end
end
