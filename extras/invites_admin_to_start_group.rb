class InvitesAdminToStartGroup
  def self.invite!(group_request)
    invitation = Invitation.create!(group_request: group_request)
    StartGroupMailer.invite_admin_to_start_group(invitation).deliver
  end
end
