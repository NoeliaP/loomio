require "#{File.dirname(__FILE__)}/../../extras/invites_admin_to_start_group"

class Invitation
end

class StartGroupMailer
end

describe InvitesAdminToStartGroup do
  let(:inviter) {stub(:inviter)}
  let(:group) {stub(creator: inviter)}
  let(:mailer) {stub(:mailer).as_null_object}
  let(:invitation) {stub(:invitation)}
  let(:admin_email) {'rob@guthrie.com'}
  let(:group_request) {stub(admin_email: admin_email, group: group, inviter: inviter)}

  before :each do
    Invitation.stub(:create!).and_return(invitation)
    invitation.stub(:token => "12345")
  end

  it 'creates an invitation for the admin' do
    StartGroupMailer.stub(:invite_admin_to_start_group).and_return(mailer)
    Invitation.should_receive(:create!).with(group_request: group_request)

    InvitesAdminToStartGroup.invite!(group_request)
  end

  it 'sends an email with the invitation token' do
    StartGroupMailer.should_receive(:invite_admin_to_start_group).
                     with(invitation).and_return(mailer)
    mailer.should_receive(:deliver)

    InvitesAdminToStartGroup.invite!(group_request)
  end
end
