class ChangeHostTable < ActiveRecord::Migration
  def change
  	change_column :hosts, :contact, :string
  end
end
