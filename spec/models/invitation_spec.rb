require 'spec_helper'

describe Invitation do
  it "generates unique random token" do
    token, token2 = stub(:token), stub(:token2)
    invitation = build(:invitation)
    GroupRequest.stub_chain(:where, :exists?).and_return(true, false)
    SecureRandom.should_receive(:urlsafe_base64).twice.and_return token, token2
    invitation.group_request.should_receive(:token=).with(token2)
    invitation.group_request.should_receive(:save!)
    invitation.send(:generate_token)
  end
end
