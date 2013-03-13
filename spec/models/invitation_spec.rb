require 'spec_helper'

describe Invitation do
  it "generates unique random token" do
    token, token2 = stub(:token), stub(:token2)
    invitation = build(:invitation)
    Invitation.stub_chain(:where, :exists?).and_return(true, false)
    SecureRandom.should_receive(:urlsafe_base64).twice.and_return token, token2
    invitation.should_receive(:token=).with(token2)
    invitation.send(:generate_token)
  end

  it "to_param returns token instead of id" do
    invitation = build(:invitation)
    invitation.stub(:token => "5235")
    invitation.to_param.should == invitation.token
  end

  describe "#accept!(user)" do
    let(:user) { create(:user) }
    let(:group) { create(:group) }
    let(:invitation) { build(:invitation) }
    let(:group_request) { stub(:group_request).as_null_object }

    before do
      Group.stub(:find).and_return(group)
      invitation.stub(group_request: group_request)
    end

    after do
      invitation.accept!(user)
    end

    it "makes the user an admin for the group" do
      group.should_receive(:add_admin!).with(user)
    end

    it "marks the invitation as accepted" do
      invitation.should_receive(:accepted=).with(true)
      invitation.should_receive(:save!)
    end

    it "marks the group request as accepted" do
      group_request.should_receive :accept!
    end
  end
end
