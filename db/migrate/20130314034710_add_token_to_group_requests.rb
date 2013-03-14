class AddTokenToGroupRequests < ActiveRecord::Migration
  class Invitation < ActiveRecord::Base
  end
  class GroupRequest < ActiveRecord::Base
  end

  def up
    add_column :group_requests, :token, :string
    GroupRequest.reset_column_information
    Invitation.find_each(batch_size: 200) do |invitation|
      group_request = GroupRequest.find(invitation.group_request_id)
      group_request.token = invitation.token
      group_request.save
    end
  end

  def down
    remove_column :group_requests, :token
  end
end
