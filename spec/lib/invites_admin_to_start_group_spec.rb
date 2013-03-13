require "#{File.dirname(__FILE__)}/../../lib/invites_admin_to_start_group"

class Invitation
end

class StartGroupMailer
end

describe InvitesAdminToStartGroup do
  let(:group) {stub(:group)}
  let(:inviter) {stub(:inviter)}
  let(:mailer) {stub(:mailer).as_null_object}
  let(:invitation) {stub(:invitation)}

  before :each do
    Invitation.stub(:create!).and_return(invitation)
    invitation.stub(:token => "12345")
  end

  it 'creates an invitation for the admin' do
    StartGroupMailer.stub(:invite_admin_to_start_group).and_return(mailer)
    admin_email = 'jon@lemmon.com'
    Invitation.should_receive(:create!).with(:admin_email => admin_email,
                                             :group => group,
                                             :inviter => inviter)

    InvitesAdminToStartGroup.invite!(:admin_email => admin_email,
                                :inviter => inviter,
                                :group => group)
  end

  it 'sends an email with the invitation token' do
    StartGroupMailer.should_receive(:invite_admin_to_start_group).
                     with(invitation).and_return(mailer)
    mailer.should_receive(:deliver)

    InvitesAdminToStartGroup.invite!(:admin_email => 'rob@guthrie.com',
                                     :inviter => inviter,
                                     :group => group)
  end
end
