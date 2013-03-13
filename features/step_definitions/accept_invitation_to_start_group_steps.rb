Given /^I have requested to start a loomio group$/ do
  @admin_email = @user ? @user.email : "test@example.org"
  @group_request = FactoryGirl.create :group_request, admin_email: @admin_email
end

Given /^the group request has been approved$/ do
  @group_request.approve!
  @group = @group_request.group
end

When /^I open the email sent to me$/ do
  open_email(@admin_email)
end

When /^I click the invitation link to start a new group$/ do
  click_first_link_in_email
end

When /^I choose to create an account$/ do
  @user_email = "blah@jah.com"
  click_on "create-account"
end

When /^I fill in and submit the new user form$/ do
  @user = FactoryGirl.create :user
  fill_in "user_name", with: @user.name
  fill_in "user_email", with: @user.email
  fill_in "user_password", with: @user.password
  click_on "submit"
end

When /^I choose to log in and then I submit the login form$/ do
  @user = FactoryGirl.create :user
  click_on "sign-in"
  fill_in "user_email", with: @user.email
  fill_in "user_password", with: @user.password
  click_on "sign-in-btn"
end

Then /^I should become the admin of the group$/ do
  @user.is_group_admin?(@group).should == true
end

Then /^the group request should be marked as accepted$/ do
  @group_request.reload
  @group_request.should be_accepted
end
