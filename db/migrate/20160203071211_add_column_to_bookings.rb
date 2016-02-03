class AddColumnToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :paid_status, :boolean, default: false
  end
end
