class AddFieldsToGroupRequest < ActiveRecord::Migration
  def change
    rename_column :group_requests, :sectors_metric, :sector
    add_column :group_requests, :admin_name, :string
    add_column :group_requests, :country_name, :string
    add_column :group_requests, :contribution_type, :string, default: "subscription"
    add_column :group_requests, :contribution_amount, :string
    add_column :group_requests, :contribution_frequency, :string, default: "monthly"
  end
end
