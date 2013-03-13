class InvitesAdminToStartGroup
  def self.invite!(args)
    admin_email = args[:admin_email]
    group = args[:group]
    inviter = args[:inviter]
    invitation = Invitation.create!(:admin_email => admin_email,
                                    :inviter => inviter,
                                    :group => group)
    StartGroupMailer.invite_admin_to_start_group(invitation).deliver
  end
end
