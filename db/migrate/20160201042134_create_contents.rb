class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
    	t.string :category_name
      t.string :category_description
      t.json :images
      t.integer :admin_id
    	
      t.timestamps null: false
    end
  end
end
