class AddBraintreeToHosts < ActiveRecord::Migration
  def change
    add_column :hosts, :braintree_host_id, :integer
  end
end
