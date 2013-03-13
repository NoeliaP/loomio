class InvitationsController < BaseController
  before_filter :get_resources
  before_filter :authenticate_user!, :except => [:show]

  def show
    if @invitation.nil? || @invitation.accepted?
      render "invitation_accepted_error_page"
    else
      session[:invitation] = @invitation.token
      @inviter = @invitation.inviter
      redirect_to group_url(@invitation.group_id) if user_signed_in?
    end
  end

  private

  def get_resources
    @group = Group.find(params[:group_id])
    @invitation = Invitation.where(:group_id => params[:group_id],
                                  :token => params[:id]).first
  end
end
