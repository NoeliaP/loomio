class AddFieldsToGroupRequest < ActiveRecord::Migration
  def change
    rename_column :group_requests, :sectors_metric, :sector
    add_column :group_requests, :admin_name, :string
    add_column :group_requests, :country_name, :string
  end
end
