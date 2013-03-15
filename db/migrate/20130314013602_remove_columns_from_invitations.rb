class RemoveColumnsFromInvitations < ActiveRecord::Migration
  def up
    remove_column :invitations, :admin_email
    remove_column :invitations, :inviter_id
    remove_column :invitations, :group_id
    remove_column :invitations, :token
    remove_column :invitations, :accepted
  end

  def down
    add_column :invitations, :admin_email, :string
    add_column :invitations, :inviter_id, :integer
    add_column :invitations, :group_id, :integer
    add_column :invitations, :token, :string
    add_column :invitations, :accepted, :boolean
  end
end
