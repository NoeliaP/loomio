class InvitationsController < BaseController
  before_filter :get_resources
  before_filter :authenticate_user!, :except => [:show]

  def show
    if @invitation.nil? || @invitation.accepted?
      render "invitation_accepted_error_page"
    else
      session[:invitation] = @invitation.token
      redirect_to group_url(@invitation.group_id) if user_signed_in?
    end
  end

  private

  def get_resources
    @group = Group.find(params[:group_id])
    @invitation = Invitation.includes(:group_request).
                  where("group_requests.group_id = ?", params[:group_id]).
                  where(:token => params[:id]).first
  end
end
