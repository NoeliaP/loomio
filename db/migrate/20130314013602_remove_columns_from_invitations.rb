class RemoveColumnsFromInvitations < ActiveRecord::Migration
  def up
    remove_column :invitations, :admin_email
    remove_column :invitations, :inviter_id
    remove_column :invitations, :group_id
  end

  def down
    add_column :invitations, :admin_email, :string
    add_column :invitations, :inviter_id, :integer
    add_column :invitations, :group_id, :integer
  end
end
