class Invitation < ActiveRecord::Base
  attr_accessible :group_request

  belongs_to :group_request

  delegate :group_id, :group, :admin_email, :token, to: :group_request

  private

  def generate_token
    begin
      token = SecureRandom.urlsafe_base64
    end while GroupRequest.where(:token => token).exists?
    group_request.token = token
    group_request.save!
  end
end
