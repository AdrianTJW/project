class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.integer :user_id
      t.integer :job_id
      t.boolean :acceptance, default: false

      t.timestamps null: false
    end
  end
end
