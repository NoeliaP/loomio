Given /^I have requested to start a loomio group and the request has been approved$/ do
  @group_request = FactoryGirl.create :group_request
  @group_request.approve!
end

Then /^I should become the admin of the group$/ do
  @user.is_group_admin?(@group).should == true
end

Then /^the group request should be marked as accepted$/ do
  @group_request.reload
  @group_request.should be_accepted
end
