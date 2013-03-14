class BaseController < InheritedResources::Base
  before_filter :authenticate_user!, :check_browser, :check_invitation, :get_notifications
  # inherit_resources

  def check_browser
    if browser.ie6? # || browser.ie7?
      redirect_to browser_not_supported_url
    end
  end

  def check_invitation
    if user_signed_in? && session[:invitation]
      new_group_invitation = GroupRequest.find_by_token(session[:invitation])
      if new_group_invitation
        group_request = new_group_invitation.group_request
        unless group_request.accepted?
          group_request.accept!(current_user)
          flash[:success] = "You have been added to #{group_request.group.name}."
          session[:invitation] = nil
          redirect_to group_url(group_request.group_id)
        end
      end
    end
  end

  def get_notifications
    if user_signed_in?
      @unviewed_notifications = current_user.unviewed_notifications
      @notifications = current_user.recent_notifications
    end
  end
end
