class AddGroupRequestToInvitations < ActiveRecord::Migration
  def change
    add_column :invitations, :group_request_id, :integer
    add_index :invitations, :group_request_id
  end
end
