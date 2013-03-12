require 'spec_helper'

describe GroupRequestsController do
  let(:group_request) { build :group_request }
  describe "#new" do
    before do
      GroupRequest.stub(:new => group_request)
      get :new
    end

    it "should assign a GroupRequest object" do
      assigns(:group_request).should eq(group_request)
    end

    it "should successfully render the group request page" do
      response.should be_success
      response.should render_template("new")
    end
  end

  describe "#create" do
    it "should redirect to the contribution page" do
      post :create, :group_request => group_request.attributes
      response.should render_template("contribution")
    end
  end

  describe "#contribution" do
    it "should redirect to the confirmation page" do
      put :contribution, id: group_request.id, :group_request => {contribution_type: "donation", contribution_amount: "67", contribution_frequency: "monthly"}
      response.should redirect_to(group_request_confirmation_url)
    end
  end

  describe "#confirmation" do
    it "should successfully render the confirmation page" do
      get :confirmation
      response.should be_success
      response.should render_template("confirmation")
    end
  end

end
