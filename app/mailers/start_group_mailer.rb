class StartGroupMailer < ActionMailer::Base
  default from: "\"Loomio\" <contact@loomio.org>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.group_invitation_mailer.invite_member.subject
  #
  def invite_admin_to_start_group(invitation)
    @group = invitation.group
    @token = invitation.token

    mail to: invitation.admin_email,
         subject: "Invitation to join Loomio (#{@group.name})"
  end
end
